import 'package:oua_flutter33/app/app_base_view_model.dart';
import 'package:oua_flutter33/core/di/get_it.dart';
import 'package:oua_flutter33/core/models/cart_item_model.dart';
import 'package:oua_flutter33/core/services/cart_service.dart';


class CartListViewModel extends AppBaseViewModel {
  final CartService _cartService = getIt<CartService>();

  List<CartItem> get cartItems => _cartService.cartItems;
  double get totalPrice => _cartService.totalPrice;
  int get totalItems => _cartService.totalItems;

  void removeItem(CartItem item) {
    _cartService.removeFromCart(item);
    notifyListeners();
  }
}
