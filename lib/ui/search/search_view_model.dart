// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:oua_flutter33/app/app_base_view_model.dart';
import 'package:oua_flutter33/common/widgets/category_selectors/category_selector_view.dart';
import 'package:oua_flutter33/core/models/product_model.dart';
import 'package:oua_flutter33/core/models/view_model/product_view_model.dart';
import 'package:oua_flutter33/core/services/product_service.dart';

class SearchViewModel extends AppBaseViewModel {
  final ProductService _productService = ProductService();

  TextEditingController searchController = TextEditingController();

  List<ProductView> _products = [];
  List<ProductView> get products => _products;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _filterGrid = "specialforme";
  String get filteredGrid => _filterGrid;

  String _filter = "Senin İçin";
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
    // navigationService.navigateTo(
    //   Routes.produtDetailView,
    //   arguments: ProductDetailViewArguments(
    //     product: product,
    //   ),
    // );
  }

  Future<void> favored(Product product) async {

    
  }

  void searchChange(String value) {}

  void showFilterDialog(BuildContext context) {
    String filter = "Senin İçin";
    showModalBottomSheet(
      context: context,
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
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 120,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: filter == "Senin İçin"
                                    ? Theme.of(context).colorScheme.onPrimary
                                    : Theme.of(context).colorScheme.secondary,
                                width: 2,
                              ),
                            ),
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() => filter = "Senin İçin");
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                            ),
                            child: Text(
                              "Senin İçin",
                              style: TextStyle(
                                color: "Senin İçin" == filter
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
                                color: "account" == filter
                                    ? Theme.of(context).colorScheme.onPrimary
                                    : Theme.of(context).colorScheme.secondary,
                                width: 2,
                              ),
                            ),
                          ),
                          child: ElevatedButton(
                            onPressed: () => setState(() => filter = "account"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                            ),
                            child: Text(
                              "Profiller",
                              style: TextStyle(
                                color: "account" == filter
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
                            onPressed: () => setState(() => filter = "product"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                            ),
                            child: Text(
                              "Ürünler",
                              style: TextStyle(
                                color: "product" == filter
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
                ],
              ),
            ),
          ),
        );
      },
    );

    setFilter(filter, context);
    notifyListeners();
  }
}
