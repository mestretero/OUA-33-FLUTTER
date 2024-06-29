// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:oua_flutter33/example/example_view_model.dart';
import 'package:stacked/stacked.dart';

class ExampleView extends StatelessWidget {
  const ExampleView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ExampleViewModel>.reactive(
      viewModelBuilder: () => ExampleViewModel(),
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
