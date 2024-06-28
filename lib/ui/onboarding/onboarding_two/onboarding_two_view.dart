// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:oua_flutter33/ui/onboarding/onboarding_two/onboarding_two_view_model.dart';
import 'package:stacked/stacked.dart';

class OnboardingTwoView extends StatelessWidget {
  const OnboardingTwoView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OnboardingTwoViewModel>.reactive(
      viewModelBuilder: () => OnboardingTwoViewModel(),
      onModelReady: (model) => model.init(context),
      builder: (context, model, widget) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Onboarding Two Screen",
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      model.nextPage();
                    },
                    child: const Text("İleri"),
                  ),
                  TextButton(
                    onPressed: () {
                      model.backPage();
                    },
                    child: const Text("Geri"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
