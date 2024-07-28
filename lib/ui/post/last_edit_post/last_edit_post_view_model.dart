// ignore_for_file: unused_field, depend_on_referenced_packages, implementation_imports

import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:oua_flutter33/app/app.router.dart';
import 'package:oua_flutter33/core/services/post_service.dart';
import 'package:path/path.dart' as p;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oua_flutter33/app/app_base_view_model.dart';
import 'package:oua_flutter33/core/di/get_it.dart';
import 'package:oua_flutter33/core/models/media_model.dart';
import 'package:oua_flutter33/core/models/post_model.dart';
import 'package:oua_flutter33/core/models/product_model.dart';
import 'package:oua_flutter33/core/models/user_model.dart';
import 'package:oua_flutter33/core/services/media_service.dart';

class LastEditPostViewModel extends AppBaseViewModel {
  final MediaService _mediaService = getIt<MediaService>();
  final PostService _postService = getIt<PostService>();

  User? _user;
  User? get user => _user;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool isShowProducts = false;

  final List<XFile> _images = [];
  final List<Product> _products = [];

  TextEditingController explanationController = TextEditingController();
  String? _location = "Lütfen Seçiniz";
  String? get location => _location;

  Future<void> init(BuildContext context) async {
    await fetchUser();
  }

  void setLocation(String location) {
    _location = location;
    notifyListeners();
  }

  //getUserDetail
  Future<void> fetchUser() async {
    _isLoading = true;
    notifyListeners();

    _user = await userService.getUserData();

    _isLoading = false;
    notifyListeners();
  }

  void changeShowProduct() {
    if (isShowProducts) {
      isShowProducts = false;
    } else {
      isShowProducts = true;
    }
    notifyListeners();
  }

  Future<List<Media>> uploadMedia(List<File?> files) async {
    List<Media> medias = [];

    for (int i = 0; i < files.length; i++) {
      File file = files[i]!;
      String url = await _mediaService.uploadFile(file.path, "images/products");

      String fileExtension = p.extension(file.path);

      medias.add(Media(type: fileExtension, url: url));
    }
    return medias;
  }

  Future<void> sharePost(
    BuildContext context,
    List<XFile> images,
    List<Product> products,
  ) async {
    if (_isInvalid() == false) return showErrorMessage(context);

    _isLoading = true;

    List<File> files = [];
    List<RelatedProducts> relatedProducts = [];

    for (var item in images) {
      files.add(File(item.path));
    }

    List<Media> medias = await uploadMedia(files);

    for (var item in products) {
      relatedProducts.add(
        RelatedProducts(
          productId: item.id.toString(),
          name: item.name,
          imageUrl: item.mainImageUrl,
        ),
      );
    }

    await _postService
        .addPost(
      Post(
        uid: user!.uid,
        createDate: Timestamp.now(),
        isActive: true,
        explanation: explanationController.text,
        medias: medias,
        relatedProducts: relatedProducts,
        location: location ?? "",
        countOfLikes: 0,
        countOfComments: 0,
      ),
    )
        .then((_) {
      _isLoading = false;
      navigationService.navigateTo(Routes.mainView);
    });
  }

  bool _isInvalid() {
    if (explanationController.text.isEmpty) return false;
    return true;
  }

  void showErrorMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error"),
          content: const Text("Error Message"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Tamam"),
            ),
          ],
        );
      },
    );
  }
}
