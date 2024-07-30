// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:oua_flutter33/app/app.router.dart';
import 'package:oua_flutter33/common/helpers/toast_functions.dart';
import 'package:oua_flutter33/core/models/comment_model.dart';
import 'package:oua_flutter33/core/models/post_model.dart';
import 'package:oua_flutter33/core/models/response_model.dart';
import 'package:oua_flutter33/core/models/view_model/comment_view.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:flutter/material.dart';
import 'package:oua_flutter33/app/app_base_view_model.dart';
import 'package:oua_flutter33/common/helpers/scaler.dart';
import 'package:oua_flutter33/common/helpers/string_functions.dart';
import 'package:oua_flutter33/core/models/user_model.dart';
import 'package:oua_flutter33/core/models/view_model/post_view_model.dart';
import 'package:oua_flutter33/core/services/post_service.dart';

class PostDetailViewModel extends AppBaseViewModel {
  final PostService _postService = PostService();

  final TextEditingController _commentCntrl = TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  User? _userData;
  User? get userData => _userData;

  PostViewModel? _postView;
  PostViewModel? get postView => _postView;

  bool isShowProducts = false;
  String showProductPostId = "";

  init(String postId) {
    _fetchData(postId);
  }

  Future<void> refreshPosts() async {
    _fetchData(postView!.post.id ?? "");
  }

  Future<void> _fetchData(String postId) async {
    _isLoading = true;
    if (postId.isNotEmpty || postId != "") {
      _postView = await _postService.getPostViewModelById(postId);
      _userData = await userService.getUserData();
    }
    _isLoading = false;
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

    data.post.countOfLikes += 1;
    notifyListeners();
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

  void goToProfil(String? userId) {
    if (userId != userData!.uid) {
      navigationService.navigateTo(
        Routes.profileView,
        arguments: ProfileViewArguments(profileUid: userId),
      );
    }
  }

  void goToProductDetail(String id) {
    navigationService.navigateTo(
      Routes.productDetailView,
      arguments: ProductDetailViewArguments(productId: id),
    );
  }

  Future<void> sendComment(BuildContext context, PostViewModel data) async {
    if (data.post.id!.isEmpty || userData!.uid.isEmpty) {
      return;
    } else {
      final scaffold = ScaffoldMessenger.of(context);
      MyToast.showLoadingToast(scaffold, context, "");

      ResponseModel result = await _postService.sendComment(
        data.post.id ?? "",
        Comment(
          uid: userData!.uid,
          comment: _commentCntrl.text,
          createDate: Timestamp.now(),
          isActive: true,
        ),
      );

      MyToast.closeToast(scaffold);

      if (result.success) {
        refreshPosts();
      } else {
        MyToast.showErrorTost(context, result.message);
      }
    }
  }

  //Bottom Sheets
  void showBottomSheetForUsersWhoLike(
    BuildContext context,
    PostViewModel data,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext bc) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return Container(
              width: Scaler.width(1, context),
              height: Scaler.width(1, context),
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Beğenmeler",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "${data.peopleWhoLike.length} beğenme",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: data.peopleWhoLike.length,
                      itemBuilder: (context, index) {
                        var item = data.peopleWhoLike[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () => goToProfil(item.uid),
                                    child: Container(
                                      width: 56,
                                      height: 56,
                                      margin: const EdgeInsets.only(right: 8),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(999),
                                        image: DecorationImage(
                                          image: NetworkImage(item.imageUrl),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${item.name.capitalize()} ${item.surname.capitalize()}",
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        timeago.format(
                                          item.createDate.toDate(),
                                        ),
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                          fontSize: 14,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              const Icon(
                                Icons.favorite_rounded,
                                color: Colors.red,
                                size: 24,
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void showBottomSheetForComments(
    BuildContext context,
    PostViewModel data,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext bc) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return Container(
              width: Scaler.width(1, context),
              height: Scaler.width(1, context),
              padding: const EdgeInsets.all(16),
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(bc).viewInsets.bottom,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: data.comments.length,
                      itemBuilder: (context, index) {
                        var item = data.comments[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () => goToProfil(item.user.uid),
                                child: Container(
                                  width: 44,
                                  height: 44,
                                  margin: const EdgeInsets.only(right: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(999),
                                    image: DecorationImage(
                                      image: NetworkImage(item.user.imageUrl),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${item.user.name.capitalize()} ${item.user.surname.capitalize()}",
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        timeago.format(
                                            item.comment.createDate.toDate()),
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
                                    child: Text(
                                      item.comment.comment,
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary
                                            .withOpacity(0.5),
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  // Comment Input
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: Scaler.width(0.78, context),
                          child: TextFormField(
                            enabled: true,
                            controller: _commentCntrl,
                            maxLength: 128,
                            keyboardType: TextInputType.text,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 16,
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              isDense: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(16)),
                              ),
                              hintText:
                                  "@${data.user!.name}_${data.user!.surname} için bir yorum ekle...",
                              hintStyle: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 14,
                              ),
                              counterText: "",
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(16)),
                              ),
                              alignLabelWithHint: true,
                            ),
                          ),
                        ),
                        IconButton(
                          style: IconButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.onPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(999),
                            ),
                          ),
                          onPressed: () async {
                            await sendComment(context, data);
                            setState(() {
                              data.comments.add(
                                CommentView(
                                  user: userData!,
                                  comment: Comment(
                                    uid: userData!.uid,
                                    comment: _commentCntrl.text,
                                    createDate: Timestamp.now(),
                                    isActive: true,
                                  ),
                                ),
                              );
                              _commentCntrl.clear();
                            });
                          },
                          icon: const Icon(
                            Icons.send_sharp,
                            color: Colors.white,
                            size: 20,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
