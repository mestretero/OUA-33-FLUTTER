import 'package:oua_flutter33/core/models/cart_%C4%B1tem_model.dart';

class Cart {
  final List<CartItem> items;

  Cart({required this.items});

  double get totalPrice {
    return items.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  int get totalItems {
    return items.fold(0, (sum, item) => sum + item.quantity);
  }
}


