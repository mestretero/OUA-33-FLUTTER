// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:oua_flutter33/common/widgets/my_button.dart';
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
                      image: AssetImage("assets/images/onboarding-img-3.png"),
                    ),
                  ),
                ),
                const SizedBox(height: 48),
                Text(
                  "Zanaatkar \n Topluluğuna Katılın",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Usta Eller, zanaatkarları ve el işi meraklılarını bir araya getiren canlı bir topluluktur. Gönderilerinizi paylaşın, yorum yapın ve alıcılarla doğrudan mesajlaşarak etkileşime geçin. El emeğinizi dünyaya tanıtın!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 16),
                MyButton(
                  text: "HAYDİ BAŞLAYALIM",
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
