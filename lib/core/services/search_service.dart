import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:oua_flutter33/core/models/post_model.dart';
import 'package:oua_flutter33/core/models/product_model.dart';
import 'package:oua_flutter33/core/models/user_model.dart';
import 'package:oua_flutter33/core/models/view_model/search_result_view.dart';

class SearchService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  Future<SearchResultView> search({
    required String? searchText,
    required String searchType,
    String? location,
    String? category,
    String? subCategory,
    String? subSubCategory,
  }) async {
    List<Product> products = [];
    List<Post> posts = [];
    List<User> users = [];

    if (searchType == 'all' || searchType == 'product') {
      Query query =
          _firestore.collection('products').where('is_active', isEqualTo: true);

      if (category != null && category.isNotEmpty) {
        query = query.where('category_id', isEqualTo: category);
      }
      if (subCategory != null && subCategory.isNotEmpty) {
        query = query.where('sub_category_id', isEqualTo: subCategory);
      }
      if (subSubCategory != null && subSubCategory.isNotEmpty) {
        query = query.where('sub_sub_category_id', isEqualTo: subSubCategory);
      }

      QuerySnapshot querySnapshot = await query.get();
      List<Product> allProducts = querySnapshot.docs
          .map((doc) => Product.fromDocumentSnapshot(doc))
          .toList();

      if (searchText != null && searchText.isNotEmpty) {
        String searchTextLower = searchText.toLowerCase();
        products = allProducts.where((product) {
          String nameLower = product.name.toLowerCase();
          return nameLower.startsWith(searchTextLower);
        }).toList();
      } else {
        products = allProducts;
      }
    }

    if (searchType == 'all' || searchType == 'post') {
      Query query =
          _firestore.collection('posts').where('is_active', isEqualTo: true);

      if (location != null && location.isNotEmpty) {
        query = query.where('location', isEqualTo: location);
      }

      QuerySnapshot querySnapshot = await query.get();
      List<Post> allPosts = querySnapshot.docs
          .map((doc) => Post.fromDocumentSnapshot(doc))
          .toList();

      if (searchText != null && searchText.isNotEmpty) {
        String searchTextLower = searchText.toLowerCase();
        posts = allPosts.where((post) {
          String explanationLower = post.explanation.toLowerCase();
          return explanationLower.startsWith(searchTextLower);
        }).toList();
      } else {
        posts = allPosts;
      }
    }

    if (searchType == 'all' || searchType == 'profil') {
      Query query =
          _firestore.collection('users').where('is_active', isEqualTo: true);
      QuerySnapshot querySnapshot = await query.get();
      List<User> allUsers = querySnapshot.docs
          .map((doc) => User.fromDocumentSnapshot(doc))
          .toList();

      if (searchText != null && searchText.isNotEmpty) {
        String searchTextLower = searchText.toLowerCase();
        users = allUsers.where((user) {
          String nameLower = user.name.toLowerCase();
          return nameLower.startsWith(searchTextLower);
        }).toList();
      } else {
        users = allUsers
            .where((item) => item.uid != _auth.currentUser!.uid)
            .toList();
      }
    }

    return SearchResultView(
      products: products,
      posts: posts,
      users: users,
    );
  }
}
