import 'package:flutter/material.dart';
import 'package:oua_flutter33/app/app.router.dart';
import 'package:oua_flutter33/app/app_base_view_model.dart';
import 'package:oua_flutter33/common/helpers/toast_functions.dart';

class RegisterViewModel extends AppBaseViewModel {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();

  init(BuildContext context) {}

  Future<void> register(BuildContext context) async {
    final scaffold = ScaffoldMessenger.of(context);

    MyToast.showLoadingToast(
        scaffold, context, "İşleminiz gerçleştiriliyor...");

    if (_isInvalid()) {
      await authServices.register(
        context,
        nameController.text,
        surnameController.text,
        emailController.text,
        passController.text,
      );
      MyToast.closeToast(scaffold);
    } else {
      Future.delayed(
        const Duration(seconds: 2),
        () {
          MyToast.closeToast(scaffold);
          MyToast.showErrorTost(
              context, "Lütfen, doldurmanız gereken alanları kontrol ediniz.");
        },
      );
    }
  }

  void goToLogin(BuildContext context) {
    navigationService.navigateTo(Routes.loginView)?.then((_) {
      formKey.currentState?.reset();
      FocusScope.of(context).requestFocus(FocusNode());
    });
  }

  bool _isInvalid() {
    if (emailController.text.isEmpty || emailController.text == "") {
      return false;
    }
    if (passController.text.isEmpty || passController.text == "") return false;
    if (surnameController.text.isEmpty || surnameController.text == "") {
      return false;
    }
    if (nameController.text.isEmpty || nameController.text == "") return false;
    if (formKey.currentState!.validate() == false) return false;

    return true;
  }
}
