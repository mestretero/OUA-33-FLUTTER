import 'package:flutter/material.dart';
import 'package:oua_flutter33/app/app.router.dart';
import 'package:oua_flutter33/app/app_base_view_model.dart';
import 'package:oua_flutter33/common/helpers/scaler.dart';
import 'package:oua_flutter33/core/di/get_it.dart';
import 'package:oua_flutter33/core/models/post_model.dart';
import 'package:oua_flutter33/core/models/user_model.dart';
import 'package:oua_flutter33/core/models/view_model/post_view_model.dart';
import 'package:oua_flutter33/core/services/post_service.dart';
import 'package:oua_flutter33/core/services/user_service.dart';

class HomeViewModel extends AppBaseViewModel {
  final UserService _userService = getIt<UserService>();
  final PostService _postService = getIt<PostService>();

  User? userData;
  bool isShowProducts = false;
  String showProductPostId = "";
  List<PostViewModel> posts = [];

  @override
  void initialise() {
    _loadUserData();
    _loadPosts();
  }

  void changeShowProduct(Post post) {
    if (showProductPostId == post.id) {
      if (isShowProducts) {
        isShowProducts = false;
      } else {
        isShowProducts = true;
      }
    } else {
      isShowProducts = true;
    }
    showProductPostId = post.id ?? "";
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

  Future<void> unfavoriedPost(PostViewModel data) async {
    if (data.post.id != "" || data.post.id != null) {
      await _postService.removePostFromFavorites(data.post.id);
      userData!.favoredPostIds.removeWhere((e) => e.id == data.post.id);
    }
    notifyListeners();
  }

  Future<void> favoriedPost(PostViewModel data) async {
    if (data.post.id != "" || data.post.id != null) {
      await _postService.addPostToFavorites(data.post.id);
      userData!.favoredPostIds.add(
        ListObjectOfIds(
          id: data.post.id ?? "",
          title: data.post.uid,
          imageUrl: data.post.medias[0].url,
        ),
      );
    }
    notifyListeners();
  }

  void goToProfil(User? user) {
    if (user!.uid != userData!.uid) {
      navigationService.navigateTo(
        Routes.profileView,
        arguments: ProfileViewArguments(profileUid: user.uid),
      );
    }
  }

  //Bottom Sheets
  void showBottomSheetForUsersWhoLike(
    BuildContext context,
    PostViewModel data,
  ) {
    showModalBottomSheet(
        context: context,
        useSafeArea: true,
        builder: (
          BuildContext bc,
        ) {
          return StatefulBuilder(
            builder: (BuildContext context, setState) => Container(
              padding: const EdgeInsets.all(16),
            ),
          );
        });
  }

  void showBottomSheetForComments(
    BuildContext context,
    PostViewModel data,
  ) {
    showModalBottomSheet(
        context: context,
        useSafeArea: true,
        builder: (
          BuildContext bc,
        ) {
          return StatefulBuilder(
            builder: (BuildContext context, setState) => Container(
              width: Scaler.width(1, context),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  ...data.comments.map(
                    (item) => Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
