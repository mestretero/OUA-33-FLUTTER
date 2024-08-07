// ignore_for_file: unused_field, avoid_print

import 'package:flutter/material.dart';
import 'package:oua_flutter33/app/app.router.dart';
import 'package:oua_flutter33/app/app_base_view_model.dart';
import 'package:oua_flutter33/common/helpers/scaler.dart';
import 'package:oua_flutter33/common/widgets/category_selectors/category_selector_view.dart';
import 'package:oua_flutter33/common/widgets/my_button.dart';
import 'package:oua_flutter33/core/models/product_model.dart';
import 'package:oua_flutter33/core/models/user_model.dart';
import 'package:oua_flutter33/core/models/view_model/product_view_model.dart';
import 'package:oua_flutter33/core/services/product_service.dart';

class SearchViewModel extends AppBaseViewModel {
  final ProductService _productService = ProductService();

  TextEditingController searchController = TextEditingController();

  List<ProductView> _products = [];
  List<ProductView> get products => _products;

  User? _user;
  User? get user => _user;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _filterGrid = "specialforme";
  String get filteredGrid => _filterGrid;

  String _filter = "all";
  String _location = "Lütfen Seçiniz";
  String _selectedCategory = "";
  String _selectedSubCategory = "";
  String _selectedSubSubCategory = "";

  init(BuildContext context) {
    _loadData();
  }

  Future<void> _loadData() async {
    _isLoading = true;

    _products = await _productService.getAllProductViews();
    _user = await userService.getUserData();

    _isLoading = false;
    notifyListeners();
  }

  void setFilter(String filter, BuildContext context) {
    _filter = filter;
    notifyListeners();
  }

  void setFilterGrid(String filter) {
    _filterGrid = filter;
    notifyListeners();
  }

  void setLocation(String location) {
    _location = location;
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

  void goToProductDetail(Product product) {
    navigationService.navigateTo(
      Routes.productDetailView,
      arguments: ProductDetailViewArguments(
        productId: product.id ?? "",
      ),
    );
  }

  Future<void> favored(Product product) async {
    try {
      await _productService.addProductToFavorites(product.id);
      user!.favoredProductIds.add(
        ListObjectOfIds(
          id: product.id ?? "",
          title: product.name,
          imageUrl: product.mainImageUrl,
        ),
      );
      notifyListeners();
    } on Exception catch (e) {
      print("Failed to add product from favorites: $e");
    }
  }

  Future<void> unfavored(String? productId) async {
    try {
      if (productId != "" || productId != null) {
        await _productService.removeProductFromFavorites(productId);
        user!.favoredProductIds.removeWhere((e) => e.id == productId);
        notifyListeners();
      }
    } on Exception catch (e) {
      print("Failed to remove product from favorites: $e");
    }
  }

  void search(context) {
    Navigator.pop(context);

    navigationService.navigateTo(
      Routes.searchResultView,
      arguments: SearchResultViewArguments(
        searchText: searchController.text,
        searchType: _filter,
        location: _location == "Lütfen Seçiniz" ? "" : _location,
        category: _selectedCategory,
        subcategory: _selectedSubCategory,
        subSubCategory: _selectedSubSubCategory,
      ),
    );

    searchController.clear();
    notifyListeners();
  }

  void showFilterDialog(BuildContext contextmain) {
    String filter = "all";
    showModalBottomSheet(
      context: contextmain,
      useSafeArea: true,
      builder: (
        BuildContext bc,
      ) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) => Container(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: 48,
                    height: 8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 110,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: filter == "all"
                                      ? Theme.of(context).colorScheme.onPrimary
                                      : Theme.of(context).colorScheme.secondary,
                                  width: 2,
                                ),
                              ),
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() => filter = "all");
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                              ),
                              child: Text(
                                "Senin İçin",
                                style: TextStyle(
                                  color: "all" == filter
                                      ? Theme.of(context).colorScheme.onPrimary
                                      : Theme.of(context).colorScheme.secondary,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 100,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: "post" == filter
                                      ? Theme.of(context).colorScheme.onPrimary
                                      : Theme.of(context).colorScheme.secondary,
                                  width: 2,
                                ),
                              ),
                            ),
                            child: ElevatedButton(
                              onPressed: () => setState(() => filter = "post"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                              ),
                              child: Text(
                                "Gönderi",
                                style: TextStyle(
                                  color: "post" == filter
                                      ? Theme.of(context).colorScheme.onPrimary
                                      : Theme.of(context).colorScheme.secondary,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 100,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: "product" == filter
                                      ? Theme.of(context).colorScheme.onPrimary
                                      : Theme.of(context).colorScheme.secondary,
                                  width: 2,
                                ),
                              ),
                            ),
                            child: ElevatedButton(
                              onPressed: () =>
                                  setState(() => filter = "product"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                              ),
                              child: Text(
                                "Ürün",
                                style: TextStyle(
                                    color: "product" == filter
                                        ? Theme.of(context)
                                            .colorScheme
                                            .onPrimary
                                        : Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                    fontSize: 12),
                              ),
                            ),
                          ),

                          //
                          Container(
                            width: 120,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: filter == "profil"
                                      ? Theme.of(context).colorScheme.onPrimary
                                      : Theme.of(context).colorScheme.secondary,
                                  width: 2,
                                ),
                              ),
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() => filter = "profil");
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                              ),
                              child: Text(
                                "Profil",
                                style: TextStyle(
                                  color: "profil" == filter
                                      ? Theme.of(context).colorScheme.onPrimary
                                      : Theme.of(context).colorScheme.secondary,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //
                  const SizedBox(height: 8),
                  //
                  SizedBox(
                    width: Scaler.width(1, context),
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        isDense: true,
                        prefixIcon: Icon(
                          Icons.search,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        hintText: "Ara...",
                        hintStyle: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.5),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        enabled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.secondary,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                  //
                  const SizedBox(height: 8),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Konum",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 16),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).colorScheme.secondary,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: DropdownButton<String>(
                          elevation: 0,
                          underline: const SizedBox(),
                          isExpanded: true,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 14,
                          ),
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: Theme.of(context).colorScheme.secondary,
                            size: 32,
                          ),
                          value: _location,
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              setState(() => setLocation(newValue));
                            }
                          },
                          items: <String>[
                            "Lütfen Seçiniz",
                            'İstanbul',
                            'Ankara',
                            'İzmir',
                            'Antalya',
                            'Sivas',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  CategorySelector(
                    onChanged: (category, subCategory, subSubCategory) {
                      setCategories(category, subCategory, subSubCategory);
                      setState(() {});
                    },
                  ),

                  MyButton(
                    text: "Ara",
                    onTap: () {
                      setFilter(filter, context);
                      notifyListeners();
                      search(context);
                    },
                    isExpanded: true,
                    buttonStyle: 1,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
