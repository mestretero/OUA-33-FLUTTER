// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:oua_flutter33/ui/product/product_add/product_add_view_model.dart';
import 'package:stacked/stacked.dart';

class ProductAddView extends StatelessWidget {
  const ProductAddView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProductAddViewModel>.reactive(
      viewModelBuilder: () => ProductAddViewModel(),
      onModelReady: (model) => model.init(context),
      builder: (context, model, widget) => const Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Center(
              child: Text("Example Page"),
            ),
          ),
        ),
      ),
    );
  }
}
