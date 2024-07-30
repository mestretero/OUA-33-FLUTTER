// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:oua_flutter33/app/app.router.dart';
import 'package:oua_flutter33/app/app_base_view_model.dart';
import 'package:oua_flutter33/common/helpers/toast_functions.dart';
import 'package:oua_flutter33/core/di/get_it.dart';
import 'package:oua_flutter33/core/models/cart_item_model.dart';
import 'package:oua_flutter33/core/models/product_model.dart';
import 'package:oua_flutter33/core/models/user_model.dart';
import 'package:oua_flutter33/core/models/view_model/product_view_model.dart';
import 'package:oua_flutter33/core/services/cart_service.dart';
import 'package:oua_flutter33/core/services/product_service.dart';

class ProductDetailViewModel extends AppBaseViewModel {
  final ProductService _productService = getIt<ProductService>();
  final CartService cartService = getIt<CartService>();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isMine = false;
  bool get isMine => _isMine;

  bool _isFavoride = false;
  bool get isFavoride => _isFavoride;

  String _segmentValue = "description";
  String get segmentValue => _segmentValue;

  String _segmentText = "";
  String get segmentText => _segmentText;

  User? _user;
  User? get user => _user;

  ProductView? _productView;
  ProductView? get productView => _productView;

  void init(String productId) {
    _fetchProductDetails(productId);
  }

  Future<void> _fetchProductDetails(String productId) async {
    _isLoading = true;

    try {
      _productView = await _productService.getProductById(productId);
      _user = await userService.getUserData();
      _isLoading = false;
      changeSegment("description");
      _isMine = productView!.user.uid == user!.uid ? true : false;
      _isFavoride = user!.favoredProductIds
          .any((element) => element.id == productView!.product.id);
    } catch (e) {
      _isLoading = false;
      print("Error fetching product details: $e");
    }

    notifyListeners();
  }

  Future<void> refreshProduct(ScaffoldMessengerState scaffold) async {
    if (productView!.product.id!.isEmpty) {
      return;
    }
    _productView =
        await _productService.getProductById(productView!.product.id ?? "");

    MyToast.closeToast(scaffold);

    notifyListeners();
  }

  void changeSegment(String value) {
    _segmentValue = value;

    if ("description" == value) {
      _segmentText = productView!.product.description;
    }

    notifyListeners();
  }

  Future<void> editProduct(Product product) async {
    navigationService.navigateTo(Routes.productAddView,
        arguments: ProductAddViewArguments(
          productId: product.id,
        ));
  }

  Future<void> favored(Product product, BuildContext context) async {
    try {
      if (user != null) {
        final scaffold = ScaffoldMessenger.of(context);

        MyToast.showLoadingToast(scaffold, context, "");

        await _productService.addProductToFavorites(product.id);

        user!.favoredProductIds.add(
          ListObjectOfIds(
            id: product.id ?? "",
            title: product.name,
            imageUrl: product.mainImageUrl,
          ),
        );

        _isFavoride = true;
        refreshProduct(scaffold);
      } else {
        print("Error: User is null");
      }
    } on Exception catch (e) {
      print("Failed to add product to favorites: $e");
    }
  }

  Future<void> unfavored(BuildContext context, String? productId) async {
    try {
      if (productId != null && productId.isNotEmpty && user != null) {
        final scaffold = ScaffoldMessenger.of(context);

        MyToast.showLoadingToast(
            scaffold, context, "İşleminiz gerçleştiriliyor...");

        await _productService.removeProductFromFavorites(productId);
        user!.favoredProductIds.removeWhere((e) => e.id == productId);
        _isFavoride = false;
        refreshProduct(scaffold);

        notifyListeners();
      } else {
        print("Error: Product ID is null or User is null");
      }
    } on Exception catch (e) {
      print("Failed to remove product from favorites: $e");
    }
  }

  void addToCart() {
    if (_productView != null) {
      final productId = _productView!.product.id;
      if (productId != null) {
        // Null kontrolü
        final cartItem = CartItem(
          id: productId,
          name: _productView!.product.name,
          mainImageUrl: _productView!.product.mainImageUrl,
          price: _productView!.product.price,
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

  void sendMessage() {
    navigationService.navigateTo(Routes.chatView,
        arguments: ChatViewArguments(receiverUser: productView!.user));
  }

  Future<void> archiveProduct(BuildContext context, String? productId) async {
    // product add archive, service call function
    if (productId == null || productId == "") {
      return;
    }
    final scaffold = ScaffoldMessenger.of(context);

    MyToast.showLoadingToast(scaffold, context, "");
    try {
      await _productService.archiveProduct(productId);
      print("Product archive successfully.");
    } catch (e) {
      print("Error deleting product: $e");
    }
    refreshProduct(scaffold);
  }

  Future<void> unarchiveProduct(BuildContext context, String? productId) async {
    if (productId == null || productId == "") {
      return;
    }

    final scaffold = ScaffoldMessenger.of(context);

    MyToast.showLoadingToast(scaffold, context, "");

    try {
      await _productService.unarchiveProduct(productId);
      print("Product unarchive successfully.");
    } catch (e) {
      print("Error deleting product: $e");
    }
    refreshProduct(scaffold);
  }

  Future<void> deleteProduct(BuildContext context, String productId) async {
    final scaffold = ScaffoldMessenger.of(context);

    MyToast.showLoadingToast(scaffold, context, "");
    try {
      await _productService.deleteProduct(productId);
      print("Product deleted successfully.");
    } catch (e) {
      print("Error deleting product: $e");
    }
    refreshProduct(scaffold);
  }
}
