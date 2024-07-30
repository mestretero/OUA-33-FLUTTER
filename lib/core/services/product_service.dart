// ignore_for_file: use_build_context_synchronously, avoid_print, no_leading_underscores_for_local_identifiers, unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:oua_flutter33/core/di/get_it.dart';
import 'package:oua_flutter33/core/models/notification_model.dart';
import 'package:oua_flutter33/core/models/product_model.dart';
import 'package:oua_flutter33/core/models/response_model.dart';
import 'package:oua_flutter33/core/models/user_model.dart';
import 'package:oua_flutter33/core/models/view_model/product_view_model.dart';
import 'package:oua_flutter33/core/services/auth_service.dart';
import 'package:oua_flutter33/core/services/notification_service.dart';
import 'package:oua_flutter33/core/services/user_service.dart';

class ProductService {
  static final authService = getIt<AuthServices>();
  static final userService = getIt<UserService>();
  static final _notificationService = getIt<NotificationService>();

  static final _firestore = FirebaseFirestore.instance;
  static const _collectionName = "products";

  Future<ResponseModel> addProduct(Product product) async {
    try {
      await _firestore.collection(_collectionName).add(product.toMap());
      await userService.increaseCountOfProduct();

      return ResponseModel(success: true, message: "");
    } catch (e) {
      return ResponseModel(success: false, message: "Hata! Ürün eklenemedi...");
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      await _firestore
          .collection(_collectionName)
          .doc(productId)
          .update({"is_active": false});
    } catch (e) {
      print("Error deleting product: $e");
    }
  }

  Future<void> archiveProduct(String productId) async {
    try {
      await _firestore
          .collection(_collectionName)
          .doc(productId)
          .update({"is_archive": true});
    } catch (e) {
      print("Error deleting product: $e");
    }
  }

  Future<void> unarchiveProduct(String productId) async {
    try {
      await _firestore
          .collection(_collectionName)
          .doc(productId)
          .update({"is_archive": false});
    } catch (e) {
      print("Error deleting product: $e");
    }
  }

  Future<int> getProductFavoriteCount(String productId) async {
    try {
      DocumentSnapshot productSnapshot =
          await _firestore.collection(_collectionName).doc(productId).get();

      if (productSnapshot.exists) {
        return productSnapshot.get('count_of_favored') ?? 0;
      } else {
        throw Exception("Product does not exist!");
      }
    } catch (e) {
      print("Error getting product favorite count: $e");
      return 0;
    }
  }

  Future<ResponseModel> updateProduct(
    Product product,
    String? productId,
  ) async {
    if (product == null || productId!.isEmpty || productId == "") {
      return ResponseModel(
        success: false,
        message: "Lütfen, gerekli alanları gözden geçiriniz...",
      );
    }

    try {
      // Eski ürün verilerini alın
      DocumentSnapshot oldProductSnapshot =
          await _firestore.collection(_collectionName).doc(productId).get();

      if (!oldProductSnapshot.exists) {
        return ResponseModel(
          success: false,
          message: "Ürün bulunamadı...",
        );
      }

      // Eski medya URL'lerini alın
      List<dynamic> oldMediaList = oldProductSnapshot.get('medias');
      List<String> oldMediaUrls =
          oldMediaList.map((media) => media['url'] as String).toList();

      // Yeni medya URL'lerini alın
      List<String> newMediaUrls =
          product.medias.map((media) => media.url).toList();

      // Silinmesi gereken eski medya URL'lerini belirleyin
      List<String> mediaUrlsToDelete =
          oldMediaUrls.where((url) => !newMediaUrls.contains(url)).toList();

      for (String url in mediaUrlsToDelete) {
        await _deleteFileFromUrl(url);
      }

      await _firestore
          .collection(_collectionName)
          .doc(productId)
          .update(product.toMap());

      return ResponseModel(success: true, message: "");
    } catch (e) {
      print("Error updating product: $e");
      return ResponseModel(
        success: false,
        message: "Ürün bir hatadan dolayı güncellenemedi...",
      );
    }
  }

  Future<ProductView?> getProductById(String productId) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection(_collectionName).doc(productId).get();

      Product _product = Product.fromDocumentSnapshot(doc);

      DocumentSnapshot userDoc =
          await _firestore.collection("users").doc(_product.uid).get();

      User _user = User.fromDocumentSnapshot(userDoc);

      return ProductView(
        product: _product,
        user: _user,
      );
    } catch (e) {
      print("Error getting product: $e");
      return null;
    }
  }

  Future<List<Product>> getProductsByUid(String uid) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection(_collectionName)
          .where('uid', isEqualTo: uid)
          .orderBy("create_date", descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => Product.fromDocumentSnapshot(doc))
          .toList();
    } catch (e) {
      print("Error getting products by uid: $e");
      return [];
    }
  }

  Future<List<Product>> getAllProducts() async {
    QuerySnapshot querySnapshot = await _firestore
        .collection(_collectionName)
        .where('uid', isNotEqualTo: authService.user?.uid)
        .get();

    List<Product> products = querySnapshot.docs.map((doc) {
      return Product.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();

    return products;
  }

  Future<List<ProductView>> getAllProductViews() async {
    String currentUserId = authService.user!.uid;

    QuerySnapshot productQuerySnapshot = await _firestore
        .collection(_collectionName)
        .where('uid', isNotEqualTo: currentUserId)
        .get();

    List<ProductView> productViews = [];

    for (var productDoc in productQuerySnapshot.docs) {
      Product product = Product.fromMap(
          productDoc.data() as Map<String, dynamic>, productDoc.id);

      DocumentSnapshot userDoc =
          await _firestore.collection("users").doc(product.uid).get();

      User user = User.fromDocumentSnapshot(userDoc);

      productViews.add(ProductView(product: product, user: user));
    }

    return productViews;
  }

  Future<void> addProductToFavorites(String? productId) async {
    String currentUserId = authService.user!.uid;
    DocumentReference userRef =
        _firestore.collection("users").doc(currentUserId);
    DocumentReference productRef =
        _firestore.collection(_collectionName).doc(productId);

    await _firestore.runTransaction((transaction) async {
      // Kullanıcı belgesini getir
      DocumentSnapshot userSnapshot = await transaction.get(userRef);
      if (!userSnapshot.exists) {
        throw Exception("User does not exist!");
      }

      // Ürün belgesini getir
      DocumentSnapshot productSnapshot = await transaction.get(productRef);
      if (!productSnapshot.exists) {
        throw Exception("Product does not exist!");
      }

      Product product = Product.fromDocumentSnapshot(productSnapshot);

      // Ürün verisini kullanıcı favorilerine ekle
      transaction.update(userRef, {
        'favored_product_ids': FieldValue.arrayUnion([
          {
            'id': product.id,
            'title': product.name,
            'image_url': product.mainImageUrl,
          }
        ])
      });

      // Ürünün favori sayısını arttır
      transaction
          .update(productRef, {'count_of_favored': FieldValue.increment(1)});

      await _notificationService.createNotification(
        NotificationModel(
          type: "liked",
          createDate: Timestamp.now(),
          receiverUid: product.uid,
          sendedUid: currentUserId,
          relatedId: product.id ?? "",
          relatedCollection: "product",
          relatedImageUrl: product.mainImageUrl,
          commentText: "",
          isRead: false,
          isActive: true,
        ),
      );
    });
  }

  Future<void> removeProductFromFavorites(String? productId) async {
    String currentUserId = authService.user!.uid;
    DocumentReference userRef =
        _firestore.collection("users").doc(currentUserId);
    DocumentReference productRef =
        _firestore.collection(_collectionName).doc(productId);

    await _firestore.runTransaction((transaction) async {
      // Kullanıcı belgesini getir
      DocumentSnapshot userSnapshot = await transaction.get(userRef);
      if (!userSnapshot.exists) {
        throw Exception("User does not exist!");
      }

      // Ürün belgesini getir
      DocumentSnapshot productSnapshot = await transaction.get(productRef);
      if (!productSnapshot.exists) {
        throw Exception("Product does not exist!");
      }

      Product product = Product.fromDocumentSnapshot(productSnapshot);

      // Ürün verisini kullanıcı favorilerinden çıkar
      transaction.update(userRef, {
        'favored_product_ids': FieldValue.arrayRemove([
          {
            'id': product.id,
            'title': product.name,
            'image_url': product.mainImageUrl,
          }
        ])
      });

      // Ürünün favori sayısını azalt
      transaction
          .update(productRef, {'count_of_favored': FieldValue.increment(-1)});
    });
  }

  //Private
  Future<void> _deleteFileFromUrl(String url) async {
    try {
      Reference storageRef = FirebaseStorage.instance.refFromURL(url);
      await storageRef.delete();
    } catch (e) {
      print("Error deleting file: $e");
    }
  }
}
