// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:oua_flutter33/common/widgets/my_button.dart';
import 'package:oua_flutter33/ui/onboarding/onboarding_one/onboarding_one_view_model.dart';
import 'package:stacked/stacked.dart';

class OnboardingOneView extends StatelessWidget {
  const OnboardingOneView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OnboardingOneViewModel>.reactive(
      viewModelBuilder: () => OnboardingOneViewModel(),
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
                      image: AssetImage("assets/images/onboarding-img-2.png"),
                    ),
                  ),
                ),
                const SizedBox(height: 48),
                Text(
                  "Usta Eller ile El Emeğinizi Dünyaya Tanıtın!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Usta Eller, el işi ürünlerinizi hızlı ve kolay bir şekilde sergileyip satmanıza olanak tanır. Kullanıcı dostu arayüzümüz sayesinde, ürünlerinizi dakikalar içinde listeleyin ve alıcılarla buluşun",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyButton(
                      text: "Geri",
                      onTap: () => model.backPage(),
                      buttonStyle: 2,
                      isExpanded: false,
                    ),
                    const SizedBox(width: 16),
                    MyButton(
                      text: "İleri",
                      onTap: () => model.nextPage(),
                      buttonStyle: 1,
                      isExpanded: false,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
