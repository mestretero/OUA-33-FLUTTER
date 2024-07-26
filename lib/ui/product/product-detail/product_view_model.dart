// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oua_flutter33/app/app_base_view_model.dart';
import 'package:oua_flutter33/core/di/get_it.dart';
import 'package:oua_flutter33/core/models/cart_%C4%B1tem_model.dart';
import 'package:oua_flutter33/core/models/product_model.dart';
import 'package:oua_flutter33/core/models/user_model.dart';
import 'package:oua_flutter33/core/services/auth_service.dart';
import 'package:oua_flutter33/core/services/cart_service.dart';
import 'package:oua_flutter33/core/services/product_service.dart';
import 'package:oua_flutter33/ui/chat_list/chat/chat_view.dart';

class ProductViewModel extends AppBaseViewModel {
    User? _user;
    User? get user => _user;

  final ProductService _productService = getIt<ProductService>();
  late Product? product;

  static final authService = getIt<AuthServices>();
  static final _firestore = FirebaseFirestore.instance;
  static const _collectionName = "products";
  final CartService cartService = getIt<CartService>();
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
    Future<void> favored(Product product) async {
    try {
      await _productService.addProductToFavorites(product.id);
      user!.favoredProductIds.add(
        ListObjectOfIds(
          id: product.id ?? "",
          title: product.name,
          imageUrl: product.mainImageUrl,
        ),
      );
      notifyListeners();
    } on Exception catch (e) {
      print("Failed to add product from favorites: $e");
    }
  }

  Future<void> unfavored(String? productId) async {
    try {
      if (productId != "" || productId != null) {
        await _productService.removeProductFromFavorites(productId);
        user!.favoredProductIds.removeWhere((e) => e.id == productId);
        notifyListeners();
      }
    } on Exception catch (e) {
      print("Failed to remove product from favorites: $e");
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
  if (product != null) {
    final productId = product!.id;
    if (productId != null) { // Null kontrolü
      final cartItem = CartItem(
        id: productId,
        name: product!.name,
        mainImageUrl: product!.mainImageUrl,
        price: product!.price,
      );
      cartService.addToCart(cartItem);
      notifyListeners();
    } else {
      print("Error: Product ID is null");
    }
  } else {
    print("Error: Product is null");
  }
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
