import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oua_flutter33/app/app_base_view_model.dart';
import 'package:oua_flutter33/common/helpers/toast_functions.dart';
import 'package:oua_flutter33/core/models/user_model.dart';

class EditedProfileViewModel extends AppBaseViewModel {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final emailController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

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

  void updateProfile(BuildContext context) async {
    final scaffold = ScaffoldMessenger.of(context);
    MyToast.showLoadingToast(scaffold, context, "");

    if (formKey.currentState!.validate() && user != null) {
      user?.name = nameController.text;
      user?.surname = surnameController.text;
      user?.email = emailController.text;

      await userService.updateUser(user!.uid, user!);

      navigationService.back();
    }

    MyToast.closeToast(scaffold);
  }

  //private
  Future<void> pickImage(BuildContext context) async {
    final scaffold = ScaffoldMessenger.of(context);
    MyToast.showLoadingToast(scaffold, context, "");

    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      String result = await userService.updateProfileImage(imageFile, user!);
      user?.imageUrl = result;
    }

    MyToast.closeToast(scaffold);
    notifyListeners();
  }
}
