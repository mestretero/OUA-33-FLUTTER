// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:oua_flutter33/ui/profile/settings/settings_view_model.dart';
import 'package:stacked/stacked.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SettingsViewModel>.reactive(
      viewModelBuilder: () => SettingsViewModel(),
      onModelReady: (model) => model.init(context),
      builder: (context, model, widget) => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Column(
                children: [
                  IconButton(
                    onPressed: () {
                      model.navigationService.back();
                    },
                    icon: const Icon(Icons.arrow_back_ios_rounded),
                  ),
                  const Text("Settings Page"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
