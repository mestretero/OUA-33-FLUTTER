import 'package:flutter/material.dart';
import 'package:oua_flutter33/app/app.router.dart';
import 'package:oua_flutter33/app/app_base_view_model.dart';

class OnboardingOneViewModel extends AppBaseViewModel {
  init(BuildContext context) {}

  void nextPage() {
    navigationService.navigateTo(Routes.onboardingTwoView);
  }

  void backPage() {
    navigationService.back();
  }
}
