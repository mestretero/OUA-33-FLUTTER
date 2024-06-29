import 'package:oua_flutter33/ui/auth/login/login_view.dart';
import 'package:oua_flutter33/ui/auth/register/register_view.dart';
import 'package:oua_flutter33/ui/home/home_view.dart';
import 'package:oua_flutter33/ui/main/main_view.dart';
import 'package:oua_flutter33/ui/onboarding/onboarding_one/onboarding_one_view.dart';
import 'package:oua_flutter33/ui/onboarding/onboarding_two/onboarding_two_view.dart';
import 'package:oua_flutter33/ui/onboarding/onboarding_view.dart';
import 'package:oua_flutter33/ui/splash/splash_view.dart';
import 'package:stacked/stacked_annotations.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: SplashView, initial: true),
    MaterialRoute(page: MainView),
    MaterialRoute(page: HomeView),
    MaterialRoute(page: OnboardingView),
    MaterialRoute(page: OnboardingOneView),
    MaterialRoute(page: OnboardingTwoView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: RegisterView),
  ],
)
class App {}
