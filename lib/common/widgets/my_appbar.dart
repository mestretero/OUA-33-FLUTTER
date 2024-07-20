import 'package:flutter/material.dart';
import 'package:oua_flutter33/core/di/get_it.dart';
import 'package:stacked_services/stacked_services.dart';

class MyAppBarWidget extends StatelessWidget {
  final bool isBackButton;
  final String routeName;
  final String title;
  final List<dynamic>? actions;
  final NavigationService navigationService = getIt<NavigationService>();

  MyAppBarWidget({
    Key? key,
    required this.isBackButton,
    required this.title,
    this.actions,
    required this.routeName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0.0),
      child: Row(
        children: [
          if (isBackButton)
            IconButton(
              style: ButtonStyle(
                minimumSize: const WidgetStatePropertyAll(Size(40, 40)),
                iconColor: WidgetStatePropertyAll(
                    Theme.of(context).colorScheme.primary),
                backgroundColor: WidgetStatePropertyAll(
                    Theme.of(context).colorScheme.secondary),
              ),
              onPressed: () {
                if (routeName == "") {
                  navigationService.back();
                } else {
                  navigationService.navigateTo(routeName);
                }
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 20,
              ),
            ),
          if (isBackButton)
            const SizedBox(
              width: 16,
            ),
          Text(
            title,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
