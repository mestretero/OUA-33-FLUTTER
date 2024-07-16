// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:oua_flutter33/ui/cart/cart_list_view_model.dart';
import 'package:stacked/stacked.dart';

class CartListView extends StatelessWidget {
  const CartListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CartListViewModel>.reactive(
      viewModelBuilder: () => CartListViewModel(),
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
