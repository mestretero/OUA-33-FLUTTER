// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:oua_flutter33/core/di/get_it.dart';
import 'package:oua_flutter33/core/models/product_model.dart';
import 'package:oua_flutter33/core/models/user_model.dart';
import 'package:oua_flutter33/core/models/view_model/product_view_model.dart';
import 'package:oua_flutter33/core/services/auth_service.dart';
import 'package:oua_flutter33/core/services/user_service.dart';

class ProductService {
  static final authService = getIt<AuthServices>();
  static final userService = getIt<UserService>();
  static final _firestore = FirebaseFirestore.instance;
  static const _collectionName = "products";

  Future<void> addProduct(Product product) async {
    try {
      await _firestore.collection(_collectionName).add(product.toMap());
      await userService.increaseCountOfProduct();
    } catch (e) {
      print("Error adding product: $e");
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

  Future<void> updateProduct(Product product) async {
    try {
      await _firestore
          .collection(_collectionName)
          .doc(product.id)
          .update(product.toMap());
    } catch (e) {
      print("Error updating product: $e");
    }
  }

  Future<Product?> getProductById(String productId) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection(_collectionName).doc(productId).get();
      return Product.fromDocumentSnapshot(doc);
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
}
