import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oua_flutter33/app/app.router.dart';
import 'package:oua_flutter33/app/app_base_view_model.dart';
import 'package:oua_flutter33/common/helpers/scaler.dart';
import 'package:oua_flutter33/common/helpers/toast_functions.dart';
import 'package:oua_flutter33/core/di/get_it.dart';
import 'package:oua_flutter33/core/models/post_model.dart';
import 'package:oua_flutter33/core/models/product_model.dart';
import 'package:oua_flutter33/core/models/user_model.dart';
import 'package:oua_flutter33/core/services/post_service.dart';
import 'package:oua_flutter33/core/services/product_service.dart';

class ProfileViewModel extends AppBaseViewModel {
  final ProductService _productService = getIt<ProductService>();
  final PostService _postService = getIt<PostService>();

  User? _user;
  User? get user => _user;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isFollow = false;
  bool get isFollow => _isFollow;

  List<Product> _products = [];
  List<Product> get products => _products;

  List<Post> _posts = [];
  List<Post> get posts => _posts;

  String filter = 'posts'; // posts, products

  init(BuildContext context, String? uid) {
    fetchUser(uid);
  }

  void setFilter(String filter) {
    this.filter = filter;
    notifyListeners();
  }

  Future<void> fetchUser(String? uid) async {
    _isLoading = true;
    notifyListeners();

    if (uid == null) {
      _user = await userService.getUserData();
    } else {
      _user = await userService.getUserDetail(uid);
      _isFollow = await userService.isFollowing(uid);
    }

    _products = await _productService.getProductsByUid(_user!.uid);
    _posts = await _postService.getPostsByUid(_user!.uid);

    _isLoading = false;
    notifyListeners();
  }

  void shareLink(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);

    scaffold.showSnackBar(
      SnackBar(
        elevation: 0,
        padding: const EdgeInsets.all(16),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        content: SizedBox(
          width: Scaler.width(0.7, context),
          child: Text(
            'https://master-hands/uid:${user?.uid}',
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
        ),
        action: SnackBarAction(
          label: "COPY",
          textColor: Theme.of(context).colorScheme.primary,
          onPressed: () {
            Clipboard.setData(
              ClipboardData(text: 'https://master-hands/uid:${user?.uid}'),
            );
          },
        ),
      ),
    );
  }

  void goToChat() {
    navigationService.navigateTo(
      Routes.chatView,
      arguments: ChatViewArguments(
        receiverUser: user as User,
      ),
    );
  }

  void goToProductDetail(Product product) {
    navigationService.navigateTo(
      Routes.productDetailView,
      arguments: ProductDetailViewArguments(
        productId: product.id ?? "",
      ),
    );
  }

  void goToPostDetail(String? postId) {
    navigationService.navigateTo(
      Routes.postDetailView,
      arguments: PostDetailViewArguments(
        postId: postId ?? "",
      ),
    );
  }

  void logOut(BuildContext context) async {
    final scaffold = ScaffoldMessenger.of(context);

    MyToast.showLoadingToast(scaffold, context, "");

    Future.delayed(
      const Duration(seconds: 2),
      () {
        authServices.logOut();
        MyToast.closeToast(scaffold);
      },
    );
  }

  Future<void> followUser() async {
    if (user != null) {
      await userService.followUser(user);
      _isFollow = true;
      notifyListeners();
    }
  }

  Future<void> unfollowUser() async {
    if (user != null) {
      await userService.unfollowUser(user!.uid);
      _isFollow = false;
      notifyListeners();
    }
  }
}
