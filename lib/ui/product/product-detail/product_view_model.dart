// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:oua_flutter33/app/app_base_view_model.dart';
import 'package:oua_flutter33/core/di/get_it.dart';
import 'package:oua_flutter33/core/models/cart_%C4%B1tem_model.dart';
import 'package:oua_flutter33/core/models/product_model.dart';
import 'package:oua_flutter33/core/services/cart_service.dart';
import 'package:oua_flutter33/core/services/product_service.dart';
import 'package:oua_flutter33/ui/chat_list/chat/chat_view.dart';

class ProductViewModel extends AppBaseViewModel {
  final ProductService _productService = getIt<ProductService>();
  final CartService cartService = getIt<CartService>();
  Product? product;

  init(BuildContext context) {}

  Future<void> fetchProductDetails(String productId) async {
    setBusy(true);
    try {
      product = await _productService.getProductById(productId);
      notifyListeners();
    } catch (e) {
      print("Error fetching product details: $e");
    } finally {
      setBusy(false);
    }
  }

  Future<void> updateProduct(Product product) async {
    try {
      await _productService.addProduct(product);
      notifyListeners();
    } catch (e) {
      print("Error updating product: $e");
    }
  }

  void addToCart() {
    if (product != null) {
      final productId = product!.id;
      if (productId != null) {
        // Null kontrolü
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

  Future<void> archiveProduct(String? productId) async {
    // product add archive, service call function
    if (productId == null || productId == "") {
      return;
    }

    try {
      await _productService.deleteProduct(productId);
      print("Product deleted successfully.");
    } catch (e) {
      print("Error deleting product: $e");
    }
  }

  void editProduct() {
    // Implement edit product logic
  }

  // void deleteProduct() {
  // Implement delete product logic
  //}
  Future<void> deleteProduct(String productId) async {
    try {
      await _productService.deleteProduct(productId);
      print("Product deleted successfully.");
    } catch (e) {
      print("Error deleting product: $e");
    }
  }
}
