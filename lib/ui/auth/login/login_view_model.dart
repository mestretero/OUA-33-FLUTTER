import 'package:flutter/material.dart';
import 'package:oua_flutter33/app/app.router.dart';
import 'package:oua_flutter33/app/app_base_view_model.dart';
import 'package:oua_flutter33/common/helpers/toast_functions.dart';
import 'package:oua_flutter33/core/models/response_model.dart';

class LoginViewModel extends AppBaseViewModel {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();

  init(BuildContext context) {}

  Future<void> login(BuildContext context) async {
    final scaffold = ScaffoldMessenger.of(context);

    MyToast.showLoadingToast(
        scaffold, context, "İşleminiz gerçleştiriliyor...");

    if (_isInvalid()) {
      ResponseModel result = await authServices.login(
        context,
        emailController.text,
        passController.text,
      );

      MyToast.closeToast(scaffold);

      if (result.success) {
        navigationService.navigateTo(Routes.mainView);
      } else {
        MyToast.showErrorTost(context, result.message);
      }
    } else {
      Future.delayed(
        const Duration(seconds: 2),
        () {
          MyToast.closeToast(scaffold);
          MyToast.showErrorTost(
              context, "Lütfen, mail ve şifre alanını kontrol ediniz.");
        },
      );
    }
  }

  void goToRegister(BuildContext context) {
    navigationService.navigateTo(Routes.registerView)?.then((_) {
      formKey.currentState?.reset();
      FocusScope.of(context).requestFocus(FocusNode());
    });
  }

  bool _isInvalid() {
    if (emailController.text.isEmpty || emailController.text == "") {
      return false;
    }
    if (passController.text.isEmpty || passController.text == "") return false;
    if (formKey.currentState!.validate() == false) return false;
    return true;
  }
}
