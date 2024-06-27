import 'package:flutter/material.dart';
import 'package:oua_flutter33/app/app.router.dart';
import 'package:oua_flutter33/app/app_base_view_model.dart';

class SplashViewModel extends AppBaseViewModel {
  init(BuildContext context) {
    Future<void>.delayed(const Duration(seconds: 3), () => navigationService.navigateTo(Routes.mainView));
  }
}
