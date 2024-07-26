// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:oua_flutter33/common/widgets/my_button.dart';
import 'package:oua_flutter33/common/widgets/my_texfield.dart';
import 'package:oua_flutter33/ui/auth/login/login_view_model.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

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
              key: model.formKey,
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
                    controller: model.emailController,
                    name: "",
                    hintText: "Email Adresiniz",
                    inputType: TextInputType.emailAddress,
                    prefixIcon: Icons.mail_outline,
                    isTextArea: false,
                  ),
                  MyTextField(
                    controller: model.passController,
                    name: "",
                    hintText: "Password",
                    inputType: TextInputType.text,
                    prefixIcon: Icons.lock_outline,
                    isTextArea: false,
                    obscureText: true,
                  ),
                  const SizedBox(height: 16),
                  MyButton(
                    onTap: () => model.login(context),
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
                        onPressed: () => model.goToRegister(context),
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
