import 'package:flutter/material.dart';
import 'package:oua_flutter33/core/models/category_model.dart';
import 'package:oua_flutter33/core/services/category_service.dart';

class CategoryViewModel extends ChangeNotifier {
  final CategoryService _categoryService = CategoryService();

  List<Category> _mainCategories = [];
  List<SubCategory> _subCategories = [];
  List<SubSubCategory> _subSubCategories = [];

  String? _selectedMainCategory;
  String? _selectedSubCategory;
  String? _selectedSubSubCategory;

  List<Category> get mainCategories => _mainCategories;
  List<SubCategory> get subCategories => _subCategories;
  List<SubSubCategory> get subSubCategories => _subSubCategories;

  String? get selectedMainCategory => _selectedMainCategory;
  String? get selectedSubCategory => _selectedSubCategory;
  String? get selectedSubSubCategory => _selectedSubSubCategory;

  Future<void> loadMainCategories() async {
    _mainCategories = await _categoryService.getMainCategories();
    notifyListeners();
  }

  Future<void> loadSubCategories(String categoryId) async {
    _subCategories = await _categoryService.getSubCategories(categoryId);
    notifyListeners();
  }

  Future<void> loadSubSubCategories(
      String categoryId, String subCategoryId) async {
    _subSubCategories =
        await _categoryService.getSubSubCategories(categoryId, subCategoryId);
    notifyListeners();
  }

  void selectMainCategory(String categoryId) {
    _selectedMainCategory = categoryId;
    _selectedSubCategory = null;
    _selectedSubSubCategory = null;

    // loadSubCategories fonksiyonunu bir sonraki frame'de çağır
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadSubCategories(categoryId);
    });
  }

  void selectSubCategory(String subCategoryId) {
    _selectedSubCategory = subCategoryId;
    _selectedSubSubCategory = null;

    // loadSubSubCategories fonksiyonunu bir sonraki frame'de çağır
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadSubSubCategories(_selectedMainCategory!, subCategoryId);
    });
  }

  void selectSubSubCategory(String subSubCategoryId) {
    _selectedSubSubCategory = subSubCategoryId;
    notifyListeners();
  }
}
