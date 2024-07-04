import 'package:flutter/material.dart';
import 'package:oua_flutter33/app/app_base_view_model.dart';
import 'package:oua_flutter33/core/models/user_model.dart';

class ProfileViewModel extends AppBaseViewModel {
  User? user;
  init(BuildContext context) {
    userService.getUserDetail(authServices.user!.uid).then((value) {
      user = value;
      notifyListeners();
    });
  }
}
