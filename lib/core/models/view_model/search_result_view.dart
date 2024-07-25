import 'package:oua_flutter33/core/models/post_model.dart';
import 'package:oua_flutter33/core/models/product_model.dart';
import 'package:oua_flutter33/core/models/user_model.dart';

class SearchResultView {
  final List<Product> products;
  final List<Post> posts;
  final List<User> users;

  SearchResultView({
    required this.products,
    required this.posts,
    required this.users,
  });
}
