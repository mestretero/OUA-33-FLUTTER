
class CartItem {
  final String id;
  final String name;
  final String mainImageUrl;
  final double price;
  final int quantity; // Optional: To track the quantity of each item in the cart

  CartItem({
    required this.id,
    required this.name,
    required this.mainImageUrl,
    required this.price,
    this.quantity = 1, // Default quantity is 1
  });
}
