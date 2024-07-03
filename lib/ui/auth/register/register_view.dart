// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:oua_flutter33/common/widgets/app_button.dart';
import 'package:oua_flutter33/common/widgets/custom_textfield.dart';
import 'package:oua_flutter33/common/widgets/top_title.dart';
import 'package:oua_flutter33/ui/auth/register/register_view_model.dart';
import 'package:stacked/stacked.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegisterViewModel>.reactive(
      viewModelBuilder: () => RegisterViewModel(),
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
                    title: 'Register',
                    subTitle: 'Create an account',
                  ),
                  CustomTextField(
                    controller: nameController,
                    name: 'Name',
                    prefixIcon: Icons.person_outline,
                    inputType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                  ),
                  CustomTextField(
                    controller: surnameController,
                    name: 'Surname',
                    prefixIcon: Icons.person_outline,
                    inputType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
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
                        model.authServices.register(
                          context,
                          nameController.text,
                          surnameController.text,
                          emailController.text,
                          passController.text,
                        );
                      }
                    },
                    text: "Register",
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Login"),
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
