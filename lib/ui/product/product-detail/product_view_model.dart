// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:oua_flutter33/app/app_base_view_model.dart';
import 'package:oua_flutter33/core/di/get_it.dart';
import 'package:oua_flutter33/core/models/cart_%C4%B1tem_model.dart';
import 'package:oua_flutter33/core/models/product_model.dart';
import 'package:oua_flutter33/core/models/user_model.dart';
import 'package:oua_flutter33/core/services/cart_service.dart';
import 'package:oua_flutter33/core/services/product_service.dart';
import 'package:oua_flutter33/ui/chat_list/chat/chat_view.dart';

class ProductViewModel extends AppBaseViewModel {
  User? _user;
  User? get user => _user;
  int favoriteCount = 0;

  final ProductService _productService = getIt<ProductService>();
  final CartService cartService = getIt<CartService>();
  Product? product;

  Future<void> fetchProductDetails(String productId) async {
    setBusy(true);
    try {
      product = await _productService.getProductById(productId);
      favoriteCount = await _productService.getProductFavoriteCount(productId);
      notifyListeners();
    } catch (e) {
      print("Error fetching product details: $e");
    }
  }

  Future<void> updateProduct(Product product) async {
    await _productService.addProduct(product);
  }

  bool isFavored(Product product) {
    return user != null &&
        user!.favoredProductIds.any((element) => element.id == product.id);
  }

  Future<void> favored(Product product) async {
    try {
      if (user != null) {
        await _productService.addProductToFavorites(product.id);
        user!.favoredProductIds.add(
          ListObjectOfIds(
            id: product.id ?? "",
            title: product.name,
            imageUrl: product.mainImageUrl,
          ),
        );
        notifyListeners();
      } else {
        print("Error: User is null");
      }
    } on Exception catch (e) {
      print("Failed to add product to favorites: $e");
    }
  }

  Future<void> unfavored(String? productId) async {
    try {
      if (productId != null && productId.isNotEmpty && user != null) {
        await _productService.removeProductFromFavorites(productId);
        user!.favoredProductIds.removeWhere((e) => e.id == productId);
        notifyListeners();
      } else {
        print("Error: Product ID is null or User is null");
      }
    } on Exception catch (e) {
      print("Failed to remove product from favorites: $e");
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

  Future<void> deleteProduct(String productId) async {
    try {
      await _productService.deleteProduct(productId);
      print("Product deleted successfully.");
    } catch (e) {
      print("Error deleting product: $e");
    }
  }
}
