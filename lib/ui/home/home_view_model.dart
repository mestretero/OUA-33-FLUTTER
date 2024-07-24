import 'package:oua_flutter33/app/app_base_view_model.dart';
import 'package:oua_flutter33/core/di/get_it.dart';
import 'package:oua_flutter33/core/models/user_model.dart';
import 'package:oua_flutter33/core/models/view_model/post_view_model.dart';
import 'package:oua_flutter33/core/services/post_service.dart';
import 'package:oua_flutter33/core/services/user_service.dart';

class HomeViewModel extends AppBaseViewModel {
  final UserService _userService = getIt<UserService>();
  final PostService _postService = getIt<PostService>();

  User? userData;
  bool isShowProducts = false;
  List<PostViewModel> posts = [];
  
  @override
  void initialise() {
    _loadUserData();
    _loadPosts();
  }

  void changeShowProduct() {
    if (isShowProducts) {
      isShowProducts = false;
    } else {
      isShowProducts = true;
    }
    notifyListeners();
  }

  Future<void> _loadUserData() async {
    User? data = await _userService.getUserData();
    userData = data;
    notifyListeners();
  }

  Future<void> _loadPosts() async {
    posts = await _postService.getAllPosts();
    notifyListeners();
  }
}
