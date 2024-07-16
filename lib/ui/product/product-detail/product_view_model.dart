import 'package:flutter/material.dart';
import 'package:oua_flutter33/app/app_base_view_model.dart';
import 'package:oua_flutter33/core/di/get_it.dart';
import 'package:oua_flutter33/core/models/product_model.dart';
import 'package:oua_flutter33/core/services/product_service.dart';

class ProductViewModel extends AppBaseViewModel {
  final ProductService _productService = getIt<ProductService>();
  late Product? product;

  init(BuildContext context) {}

  Future<void> fetchProductDetails(String productId) async {
    setBusy(true);
    product = await _productService.getProductById(productId);
    setBusy(false);
  }

  void addToCart() {
    // Implement add to cart logic
  }

  void sendMessage() {
    // navigate to message view with uid
  }

  void archiveProduct() {
    // product add archive, service call function
  }

  void editProduct() {
    // Implement edit product logic
  }

  void deleteProduct() {
    // Implement delete product logic
  }
}
