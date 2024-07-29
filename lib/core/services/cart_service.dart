import 'package:flutter/material.dart';
import 'package:oua_flutter33/core/models/cart_item_model.dart';

class CartService with ChangeNotifier {
  final List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  void addToCart(CartItem item) {
    // Check if the item already exists in the cart
    final existingItem = _cartItems.firstWhere(
      (cartItem) => cartItem.id == item.id,
      orElse: () => CartItem(id: '', name: '', mainImageUrl: '', price: 0),
    );

    if (existingItem.id.isNotEmpty) {
      // If the item exists, update the quantity
      _cartItems.remove(existingItem);
      _cartItems.add(CartItem(
        id: existingItem.id,
        name: existingItem.name,
        mainImageUrl: existingItem.mainImageUrl,
        price: existingItem.price,
        quantity: existingItem.quantity + item.quantity,
      ));
    } else {
      // If the item doesn't exist, add it to the cart
      _cartItems.add(item);
    }

    notifyListeners();
  }

  void removeFromCart(CartItem item) {
    _cartItems.remove(item);
    notifyListeners();
  }

  double get totalPrice {
    return _cartItems.fold(
        0, (sum, item) => sum + (item.price * item.quantity));
  }

  int get totalItems {
    return _cartItems.fold(0, (sum, item) => sum + item.quantity);
  }
}
