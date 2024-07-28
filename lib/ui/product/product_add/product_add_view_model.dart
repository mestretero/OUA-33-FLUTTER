// ignore_for_file: avoid_print, unused_import, unused_field, use_build_context_synchronously, unnecessary_null_comparison, depend_on_referenced_packages, prefer_final_fields

import 'dart:io';
import 'package:oua_flutter33/common/helpers/toast_functions.dart';
import 'package:oua_flutter33/core/models/response_model.dart';
import 'package:path/path.dart' as p;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oua_flutter33/app/app.router.dart';
import 'package:oua_flutter33/app/app_base_view_model.dart';
import 'package:oua_flutter33/core/di/get_it.dart';
import 'package:oua_flutter33/core/models/media_model.dart';
import 'package:oua_flutter33/core/models/product_model.dart';
import 'package:oua_flutter33/core/services/media_service.dart';
import 'package:oua_flutter33/core/services/product_service.dart';

class ProductAddViewModel extends AppBaseViewModel {
  final ProductService _productService = getIt<ProductService>();
  final MediaService _mediaService = getIt<MediaService>();

  final formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController shortDescController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  String selectedCurrency = 'TL';
  String _selectedCategory = "";
  String _selectedSubCategory = ' ';
  String _selectedSubSubCategory = '';

  double _price = 0;
  String _priceUnit = "";
  List<File?> _images = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void init(BuildContext context) {
    // Initialize if needed
  }

  void showErrorMessage(BuildContext context) {
    MyToast.showErrorTost(
      context,
      "Lütfen formu dikkatli şekilde doldurduğunuzdan emin olunuz...",
    );
  }

  void setPrice(double price) {
    _price = price;
    notifyListeners();
  }

  void setPriceUnit(String priceUnit) {
    _priceUnit = priceUnit;
    notifyListeners();
  }

  void setImageList(List<File?> images) {
    _images = images;
    notifyListeners();
  }

  void setCategories(
    String category,
    String subCategory,
    String subSubCategory,
  ) {
    _selectedCategory = category;
    _selectedSubCategory = subCategory;
    _selectedSubSubCategory = subSubCategory;
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

  Future<void> addProduct(BuildContext context) async {
    //Add rules and controls
    if (_isInputValid() == false) {
      return showErrorMessage(context);
    }

    final scaffold = ScaffoldMessenger.of(context);
    MyToast.showLoadingToast(scaffold, context, "");

    //Upload Files return List<Media>
    List<Media> medias = await uploadMedia(_images);

    final product = Product(
      uid: authServices.user!.uid, // Buraya gerçek kullanıcı uid'si gelecek
      name: titleController.text,
      description: descController.text,
      shortDescription: shortDescController.text,
      price: _price,
      priceUnit: _priceUnit,
      categoryId: _selectedCategory,
      subCategoryId: _selectedSubCategory,
      subSubCategoryId: _selectedSubSubCategory,
      mainImageUrl: medias[0].url,
      medias: medias,
      countOfFavored: 0,
      isArchive: false,
      isActive: true,
      createDate: Timestamp.now(),
    );

    ResponseModel result = await _productService.addProduct(product);

    MyToast.closeToast(scaffold);

    if (result.success) {
      navigationService.navigateTo(Routes.sendPostView);
    } else {
      MyToast.showErrorTost(context, result.message);
    }
  }

  bool _isInputValid() {
    if (titleController.text == null || titleController.text.isEmpty) {
      return false;
    }
    if (descController.text == null || descController.text.isEmpty) {
      return false;
    }
    if (shortDescController.text == null || shortDescController.text.isEmpty) {
      return false;
    }
    if (_price == null) return false;
    if (_priceUnit == null || _priceUnit.isEmpty) return false;
    if (_selectedCategory == null || _selectedCategory == "") return false;
    if (_selectedSubCategory == null) return false;
    if (_selectedSubSubCategory == null) return false;
    if (_images == null || _images.isEmpty) return false;
    return true;
  }
}
