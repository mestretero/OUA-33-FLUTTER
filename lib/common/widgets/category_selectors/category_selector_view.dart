// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:oua_flutter33/common/widgets/category_selectors/category_selection.dart';
import 'package:oua_flutter33/common/widgets/category_selectors/category_view_model.dart';
import 'package:provider/provider.dart';

class CategorySelector extends StatelessWidget {
  const CategorySelector({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CategoryViewModel()..loadMainCategories(),
      child: const CategorySelectorBody(),
    );
  }
}
