import 'package:flutter/material.dart';
import 'package:oua_flutter33/app/app.router.dart';
import 'package:oua_flutter33/app/app_base_view_model.dart';

class OnboardingTwoViewModel extends AppBaseViewModel {
  init(BuildContext context) {}

  void nextPage() {
    navigationService.navigateTo(Routes.mainView);
  }

  void backPage() {
    navigationService.back();
  }
}
