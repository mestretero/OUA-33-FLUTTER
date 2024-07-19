// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:oua_flutter33/app/app.router.dart';
import 'package:oua_flutter33/common/widgets/my_button.dart';
import 'package:oua_flutter33/common/widgets/my_texfield.dart';
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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/master-hands-logo.png",
                    height: 200,
                    width: 200,
                  ),
                  Text(
                  "Giriş Yap",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Hayatın her anında el yapımı bir dokunuş arayanlar için Usta Eller özenle seçilmiş el işleri ve kişisel dokunuşlarla dolu bir dünyaya kapı aralıyor.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 16),
                  MyTextField(
                    controller: emailController,
                    name: "Email Adresiniz",
                    hintText: "Email Adresiniz",
                    inputType: TextInputType.emailAddress,
                    prefixIcon: Icons.mail_outline,
                    isTextArea: false,
                  ),
                  MyTextField(
                    controller: passController,
                    name: "Password",
                    hintText: "Password",
                    inputType: TextInputType.text,
                    prefixIcon: Icons.lock_outline,
                    isTextArea: false,
                    obscureText: true,
                  ),
                  const SizedBox(height: 16),
                  MyButton(
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
                    text: "Giriş Yap",
                    buttonStyle: 1,
                    isExpanded: true,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Hesabın mevcut değil mi?",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          model.navigationService
                              .navigateTo(Routes.registerView)
                              ?.then((_) {
                            formKey.currentState?.reset();
                            FocusScope.of(context).requestFocus(FocusNode());
                          });
                        },
                        child: Text(
                          "Kayıt Ol",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ],
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
