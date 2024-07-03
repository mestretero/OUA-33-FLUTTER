// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:oua_flutter33/app/app.router.dart';
import 'package:oua_flutter33/common/widgets/app_button.dart';
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
                  Text(model.authServices.user!.uid.toString()),
                  Text(model.authServices.user!.email.toString()),
                  IconButton(
                    onPressed: () {
                      model.navigationService.navigateTo(Routes.settingsView);
                    },
                    icon: const Icon(Icons.settings),
                  ),
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
