// ignore_for_file: no_leading_underscores_for_local_identifiers, unnecessary_nullable_for_final_variable_declarations, unused_field, prefer_final_fields, unnecessary_null_comparison, use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oua_flutter33/app/app.router.dart';
import 'package:oua_flutter33/app/app_base_view_model.dart';
import 'package:oua_flutter33/common/helpers/scaler.dart';
import 'package:oua_flutter33/core/di/get_it.dart';
import 'package:oua_flutter33/core/models/product_model.dart';
import 'package:oua_flutter33/core/services/post_service.dart';
import 'package:oua_flutter33/core/services/product_service.dart';
import 'package:photo_manager/photo_manager.dart';

class SendPostViewModel extends AppBaseViewModel {
  final PostService _postService = getIt<PostService>();
  final ProductService _productService = getIt<ProductService>();

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
    PhotoManager.setIgnorePermissionCheck(false);

    PermissionState permission = await PhotoManager.requestPermissionExtend();

    if (permission.isAuth) {
      List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
        onlyAll: true,
        type: RequestType.image,
      );

      List<AssetEntity> images = await albums[0].getAssetListRange(
        start: 0,
        end: 12,
      );

      _galleryImages = images;
      selectedImage = await convertAssetEntityToXFile(_galleryImages[0]);
      notifyListeners();
    } else {
      PhotoManager.openSetting();
    }
  }

  Future<XFile?> convertAssetEntityToXFile(AssetEntity assetEntity) async {
    // AssetEntity'den dosya yolu alın
    File? file = await assetEntity.file;
    if (file == null) {
      return null;
    }

    // Dosya yolunu kullanarak XFile oluşturun
    return XFile(file.path);
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
      selectedImage = selectedGalleryImages[selectedGalleryImages.length - 1];
      notifyListeners();
    }
  }

  void updateSelectedImage(AssetEntity image) async {
    final File? file = await image.file;
    if (file != null) {
      selectedImage = XFile(file.path);
      notifyListeners();
    }
    selectedGalleryImages = [];
    notifyListeners();
  }

  Future<void> addProduct(
    BuildContext context,
  ) async {
    List<Product> products =
        await _productService.getProductsByUid(authServices.user!.uid);

    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Ürünler",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32),
                          )),
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        "Kapat",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ))
                ],
              ),
              const SizedBox(height: 16),
              ...products.map(
                (item) {
                  return InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      bool isSelected = selectedProducts
                              .where((e) => e.id == item.id)
                              .toList()
                              .isEmpty
                          ? false
                          : true;

                      if (isSelected == false) {
                        selectedProducts.add(item);
                      }
                      notifyListeners();
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).colorScheme.secondary,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            margin: const EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: NetworkImage(item.mainImageUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Scaler.width(0.65, context),
                            child: Text(
                              item.name,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
    notifyListeners();
  }

  void removeProduct(Product product) {
    _selectedProducts.remove(product);
    notifyListeners();
  }

  void nextLastEditPage(BuildContext context) {
    if (_isInvalid() == false) {
      return showErrorMessage(context);
    }

    List<XFile> images = selectedGalleryImages;
    if (selectedGalleryImages.isEmpty) {
      images.add(selectedImage!);
    }

    navigationService.navigateTo(
      Routes.lastEditPostView,
      arguments: LastEditPostViewArguments(
        images: images,
        products: selectedProducts,
      ),
    );
  }

  bool _isInvalid() {
    if (selectedProducts.isEmpty) {
      return false;
    } else {
      return true;
    }
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
