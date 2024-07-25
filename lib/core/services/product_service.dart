// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:oua_flutter33/core/di/get_it.dart';
import 'package:oua_flutter33/core/models/product_model.dart';
import 'package:oua_flutter33/core/models/user_model.dart';
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

 /*  Future<void> deleteProduct(String productId) async {
    try {
      await _firestore.collection(_collectionName).doc(productId).delete();
    } catch (e) {
      print("Error deleting product: $e");
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
 */
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

  Future<User?> getUserByProductId(String productId) async {
    try {
      // Ürünü ID'si ile alın
      DocumentSnapshot productDoc =
          await _firestore.collection(_collectionName).doc(productId).get();
      if (productDoc.exists) {
        // Kullanıcı ID'sini (uid) alın
        String uid = productDoc['uid'];
        // Kullanıcı detaylarını alın
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(uid).get();
        return User.fromDocumentSnapshot(userDoc);
      } else {
        print("Ürün bulunamadı");
        return null;
      }
    } catch (e) {
      print("Error getting user by product ID: $e");
      return null;
    }
  }
   
}




