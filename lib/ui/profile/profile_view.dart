// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:oua_flutter33/app/app.router.dart';
import 'package:oua_flutter33/common/widgets/app_button.dart';
import 'package:oua_flutter33/common/widgets/profile_image.dart';
import 'package:oua_flutter33/ui/profile/profile_view_model.dart';
import 'package:stacked/stacked.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => ProfileViewModel(),
      onModelReady: (model) => model.init(context),
      builder: (context, model, widget) => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Column(
                children: [
                  const Text("Profile Page"),
                  Text(model.user!.uid),
                  Text(model.user!.name),
                  IconButton(
                    onPressed: () {
                      model.navigationService.navigateTo(Routes.settingsView);
                    },
                    icon: const Icon(Icons.settings),
                  ),
                  ProfileImageWidget(user: model.user),
                  AppButton(
                    text: 'LogOut',
                    onTap: () {
                      model.authServices.logOut();
                    },
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
