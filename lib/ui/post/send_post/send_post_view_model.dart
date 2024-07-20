// ignore_for_file: no_leading_underscores_for_local_identifiers, unnecessary_nullable_for_final_variable_declarations, unused_field, prefer_final_fields

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oua_flutter33/app/app_base_view_model.dart';
import 'package:oua_flutter33/core/di/get_it.dart';
import 'package:oua_flutter33/core/models/product_model.dart';
import 'package:oua_flutter33/core/services/post_service.dart';
import 'package:photo_manager/photo_manager.dart';

class SendPostViewModel extends AppBaseViewModel {
  final PostService _postService = getIt<PostService>();

  List<AssetEntity> _galleryImages = [];
  XFile? selectedImage;
  List<XFile> selectedGalleryImages = [];
  List<Product> _selectedProducts = [];

  List<AssetEntity> get galleryImages => _galleryImages;
  List<Product> get selectedProducts => _selectedProducts;

  Future<void> init(BuildContext context) async {
    await _loadGalleryImages();
  }

  Future<void> _loadGalleryImages() async {
    // Set the ignore permission check to false to handle permissions manually
    PhotoManager.setIgnorePermissionCheck(false);

    // Request the permissions
    PermissionState permission = await PhotoManager.requestPermissionExtend();

    // Check if the permissions are granted
    if (permission.isAuth) {
      // Get the list of albums
      List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
        onlyAll: true,
        type: RequestType.image,
      );

      // Get images from the first album, specify range if needed
      List<AssetEntity> images = await albums[0].getAssetListRange(
        start: 0,
        end: 12, // İstediğiniz resim sayısını belirleyin
      );

      // Assign the images to your gallery images list
      _galleryImages = images;
      notifyListeners();
    } else {
      // If permissions are not granted, open the settings
      PhotoManager.openSetting();
    }
  }

  Future<void> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage = image;
      notifyListeners();
    }
  }

  Future<void> openCamera() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      selectedImage = image;
      notifyListeners();
    }
  }

  Future<void> pickMultipleImages() async {
    final ImagePicker _picker = ImagePicker();
    final List<XFile>? images = await _picker.pickMultiImage();
    if (images != null && images.isNotEmpty) {
      selectedGalleryImages = images;
      selectedImage = selectedGalleryImages[selectedGalleryImages.length -1];
      notifyListeners();
    }
  }

  void updateSelectedImage(AssetEntity image) async {
    final File? file = await image.file;
    if (file != null) {
      selectedImage = XFile(file.path);
      notifyListeners();
    }
  }

  void addProduct() {
    // Add your product selection logic here
  }

  void removeProduct(Product product) {
    _selectedProducts.remove(product);
    notifyListeners();
  }

  // Future<void> createPost(String description) async {
  //   // Create Post instance
  //   Post newPost = Post(
  //     uid: "user_id", // Replace with actual user ID
  //     description: description,
  //     medias: [], // You will need to handle media upload separately
  //     isActive: true,
  //     createDate: Timestamp.now(),
  //     productIds: selectedProducts.map((p) => p.id!).toList(),
  //     likesUserId: [],
  //     countOfLikes: 0,
  //     countOfComments: 0,
  //     comments: [],
  //   );

  //   // Add post to Firestore
  //   // await _postService.addPost(newPost);
  // }
}
