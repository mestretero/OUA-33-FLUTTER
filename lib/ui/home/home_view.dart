// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:oua_flutter33/app/app.router.dart';
import 'package:oua_flutter33/ui/home/home_view_model.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (viewModel) => viewModel.initialise(),
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Column(
                children: [
                  IconButton(
                    onPressed: () {
                      model.navigationService
                          .navigateTo(Routes.notificationView);
                    },
                    icon: const Icon(Icons.notifications),
                  ),
                  const Text("Home Screen"),
                  IconButton(
                    onPressed: () {
                      model.navigationService.navigateTo(
                        Routes.productDetailView,
                        arguments: const ProductDetailViewArguments(
                          productId: "1",
                        ),
                      );
                    },
                    icon: const Icon(Icons.pool_rounded),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
