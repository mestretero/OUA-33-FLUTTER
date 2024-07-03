// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:oua_flutter33/ui/notification/notification_view_model.dart';
import 'package:stacked/stacked.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NotificationViewModel>.reactive(
      viewModelBuilder: () => NotificationViewModel(),
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
                  const Text("Notification Page"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
