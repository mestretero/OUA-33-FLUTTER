// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:oua_flutter33/common/widgets/my_button.dart';
import 'package:oua_flutter33/ui/onboarding/onboarding_view_model.dart';
import 'package:stacked/stacked.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OnboardingViewModel>.reactive(
      viewModelBuilder: () => OnboardingViewModel(),
      onModelReady: (model) => model.init(context),
      builder: (context, model, widget) => Scaffold(
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(24.0),
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/images/bg-2.png"),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 230,
                  width: 230,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(999.0),
                    image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/onboarding-img-1.png"),
                    ),
                  ),
                ),
                const SizedBox(height: 48),
                Text(
                  "Usta Eller'e Hoş Geldiniz!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Bir zamanlar, el emeği ürünler üreten, fakat bunları satacak platform bulmakta zorlanan bir grup yetenekli zanaatkar vardı. Her biri, elleriyle ürettikleri eşsiz ve özel ürünleri sergileyebilecekleri, alıcılarla buluşabilecekleri bir yer arayışındaydı. Bu arayış, onları 'Usta Eller' adını verdikleri harika bir platform yaratmaya yöneltti.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 16),
                MyButton(
                  text: "İleri",
                  onTap: () => model.nextPage(),
                  buttonStyle: 1,
                  isExpanded: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
