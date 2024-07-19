// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:oua_flutter33/app/app.router.dart';
import 'package:oua_flutter33/common/widgets/my_button.dart';
import 'package:oua_flutter33/common/widgets/my_texfield.dart';
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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/master-hands-logo.png",
                    height: 200,
                    width: 200,
                  ),
                  Text(
                    "Kayıt Ol",
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
                  MyTextField(
                    controller: nameController,
                    name: "Name",
                    hintText: "Name",
                    inputType: TextInputType.name,
                    prefixIcon: Icons.person_outline,
                    isTextArea: false,
                    textCapitalization: TextCapitalization.words,
                  ),
                  MyTextField(
                    controller: surnameController,
                    name: "Surname",
                    hintText: "Surname",
                    inputType: TextInputType.name,
                    prefixIcon: Icons.person_outline,
                    isTextArea: false,
                    textCapitalization: TextCapitalization.words,
                  ),
                  MyTextField(
                    controller: emailController,
                    name: "Email",
                    hintText: "Email",
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
                        model.authServices.register(
                          context,
                          nameController.text,
                          surnameController.text,
                          emailController.text,
                          passController.text,
                        );
                      }
                    },
                    text: "Kayıt Ol",
                    buttonStyle: 1,
                    isExpanded: true,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Zaten hesabınız var mı?",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          model.navigationService
                              .navigateTo(Routes.loginView)
                              ?.then((_) {
                            formKey.currentState?.reset();
                            FocusScope.of(context).requestFocus(FocusNode());
                          });
                        },
                        child: Text(
                          "Giriş Yap",
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
