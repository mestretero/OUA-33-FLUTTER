// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:oua_flutter33/common/helpers/string_functions.dart';
import 'package:oua_flutter33/common/widgets/my_appbar.dart';
import 'package:oua_flutter33/common/widgets/my_button.dart';
import 'package:oua_flutter33/common/widgets/my_texfield.dart';
import 'package:oua_flutter33/core/models/user_model.dart';
import 'package:oua_flutter33/ui/profile/edited_profile/edited_profile_view_model.dart';
import 'package:stacked/stacked.dart';

class EditedProfileView extends StatelessWidget {
  const EditedProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EditedProfileViewModel>.reactive(
      viewModelBuilder: () => EditedProfileViewModel(),
      onModelReady: (model) => model.init(context),
      builder: (context, model, widget) => Scaffold(
        body: model.isLoading
            ? const Center(child: CircularProgressIndicator())
            : SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        MyAppBarWidget(
                          isBackButton: true,
                          title: "Profil Düzenleme",
                          routeName: "",
                        ),
                        _buildEditForm(context, model, model.user),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildEditForm(
      BuildContext context, EditedProfileViewModel model, User? user) {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final surnameController = TextEditingController();
    final emailController = TextEditingController();

    nameController.text = user!.name.capitalize();
    surnameController.text = user.surname.capitalize();
    emailController.text = user.email;

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 104,
            width: 104,
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.onPrimary,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(999.0),
              image: DecorationImage(
                image: NetworkImage(user.imageUrl),
              ),
            ),
          ),
          const SizedBox(height: 8),
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
          const SizedBox(height: 16),
          MyButton(
            onTap: () {
              if (formKey.currentState!.validate()) {
                //User update fonksiyonu
              }
            },
            text: "Kayıt Ol",
            buttonStyle: 1,
            isExpanded: true,
          ),
        ],
      ),
    );
  }
}
