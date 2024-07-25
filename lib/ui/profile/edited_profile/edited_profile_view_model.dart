import 'package:flutter/material.dart';
import 'package:oua_flutter33/app/app_base_view_model.dart';
import 'package:oua_flutter33/core/models/user_model.dart';

class EditedProfileViewModel extends AppBaseViewModel {
  User? _user;
  User? get user => _user;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  init(BuildContext context) {
    fetchUser();
  }

  Future<void> fetchUser() async {
    _isLoading = true;
    notifyListeners();

    _user = await userService.getUserData();

    _isLoading = false;
    notifyListeners();
  }
}
