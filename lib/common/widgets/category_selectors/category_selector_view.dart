// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:oua_flutter33/common/widgets/category_selectors/category_selection.dart';
import 'package:oua_flutter33/common/widgets/category_selectors/category_view_model.dart';
import 'package:oua_flutter33/ui/product/product_add/product_add_view_model.dart';
import 'package:provider/provider.dart';

class CategorySelector extends StatelessWidget {
  final ProductAddViewModel? model;
  final Function(String category, String subCategory, String subSubCategory)
      onChanged;

  const CategorySelector({super.key, required this.onChanged, this.model});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CategoryViewModel()..loadMainCategories(model),
      child: CategorySelectorBody(
        model: model,
        onChangedCategory: (category, subCategory, subSubCategory) {
          onChanged(category, subCategory, subSubCategory);
        },
      ),
    );
  }
}
