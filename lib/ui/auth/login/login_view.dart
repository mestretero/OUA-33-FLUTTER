// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:oua_flutter33/app/app.router.dart';
import 'package:oua_flutter33/common/widgets/app_button.dart';
import 'package:oua_flutter33/common/widgets/custom_textfield.dart';
import 'package:oua_flutter33/common/widgets/top_title.dart';
import 'package:oua_flutter33/ui/auth/login/login_view_model.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      onModelReady: (model) => model.init(context),
      builder: (context, model, widget) => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TopTitle(
                    title: 'Login',
                    subTitle: 'Welcome back',
                  ),
                  CustomTextField(
                    controller: emailController,
                    name: 'Email',
                    prefixIcon: Icons.mail_outline,
                    inputType: TextInputType.emailAddress,
                  ),
                  CustomTextField(
                    controller: passController,
                    name: 'Password',
                    prefixIcon: Icons.lock_outline,
                    inputType: TextInputType.text,
                    obscureText: true,
                  ),
                  AppButton(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        model.authServices.login(
                          context,
                          emailController.text,
                          passController.text,
                        );

                        model.navigationService.navigateTo(Routes.mainView);
                      }
                    },
                    text: "Login",
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        model.navigationService.navigateTo(Routes.registerView);
                      },
                      child: const Text("Register"),
                    ),
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
