// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oua_flutter33/app/app_base_view_model.dart';
import 'package:oua_flutter33/core/di/get_it.dart';
import 'package:oua_flutter33/core/models/product_model.dart';
import 'package:oua_flutter33/core/services/auth_service.dart';
import 'package:oua_flutter33/core/services/product_service.dart';
import 'package:oua_flutter33/ui/chat_list/chat/chat_view.dart';

class ProductViewModel extends AppBaseViewModel {
  final ProductService _productService = getIt<ProductService>();
  late Product? product;
  static final authService = getIt<AuthServices>();
  static final _firestore = FirebaseFirestore.instance;
  static const _collectionName = "products";
  /* final UserService userService = getIt<UserService>();
  static final auth = FirebaseAuth.instance;
  var user = auth.currentUser; */


  init(BuildContext context) {}

  Future<void> fetchProductDetails(String productId) async {
    setBusy(true);
    try {
    product = await _productService.getProductById(productId);
    notifyListeners();
    print("Fetched product: ${product?.name}"); // Debugging output
  } catch (e) {
    print("Error fetching product details: $e");
  } finally {
    setBusy(false);
  }
  }
  
  Future<void> updateProduct(Product product) async {
    try {
      await _firestore
          .collection(_collectionName)
          .doc(product.id)
          .update(product.toMap());
          notifyListeners();
    } catch (e) {
      print("Error updating product: $e");
    }
  }

  void addToCart() {
    // Implement add to cart logic
  }

void sendMessage(BuildContext context, String productId) {
  userService.getUserByProductId(productId).then((user) {
    if (user != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatView(receiverUser: user),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Kullanıcı Bulunamadı")),
      );
    }
  }).catchError((error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Hata: $error")),
    );
  });
}


  void archiveProduct() {
    // product add archive, service call function
  }

  void editProduct() {
    // Implement edit product logic
  }

 // void deleteProduct() {
    // Implement delete product logic
  //}
  Future<void> deleteProduct(String productId) async {
    try {
      await _firestore.collection(_collectionName).doc(productId).delete();
      print("Product deleted successfully.");
    } catch (e) {
      print("Error deleting product: $e");
    }
  }

  

}
