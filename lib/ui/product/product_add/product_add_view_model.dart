// ignore_for_file: avoid_print, unused_import, unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oua_flutter33/app/app.router.dart';
import 'package:oua_flutter33/app/app_base_view_model.dart';
import 'package:oua_flutter33/core/di/get_it.dart';
import 'package:oua_flutter33/core/models/product_model.dart';
import 'package:oua_flutter33/core/services/product_service.dart';

class ProductAddViewModel extends AppBaseViewModel {
  final ProductService _productService = getIt<ProductService>();

  final formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController shortDescController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  String selectedCurrency = 'USD'; // Başlangıçta seçili para birimi
  final String _selectedCategory = 'Dekorasyon';
  double? _price;
  int? _amount;

  String get selectedCategory => _selectedCategory;

  void init(BuildContext context) {
    // Initialize if needed
  }

  void setPrice(double price) {
    _price = price;
    notifyListeners();
  }

  void setAmount(int amount) {
    _amount = amount;
    notifyListeners();
  }

  Future<void> addProduct() async {
    navigationService.navigateTo(Routes.sendPostView);

    //Add rules and controls
    // final product = Product(
    //   uid: authServices.user!.uid, // Buraya gerçek kullanıcı uid'si gelecek
    //   title: titleController.text,
    //   shortDescription: shortDescController.text,
    //   description: descController.text,
    //   categoryId: _selectedCategory,
    //   price: _price!,
    //   amount: _amount!,
    //   mainImageUrl: 'main_image_url',
    //   imageUrl: 'image_url',
    //   favoriteCount: 0,
    //   medias: [],
    //   isActive: true,
    //   createDate: Timestamp.now(),
    // );

    // print(product);

    // await _productService.addProduct(product);
  }
}
