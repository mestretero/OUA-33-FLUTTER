import 'package:oua_flutter33/example/example_view.dart';
import 'package:oua_flutter33/ui/auth/login/login_view.dart';
import 'package:oua_flutter33/ui/auth/register/register_view.dart';
import 'package:oua_flutter33/ui/cart/cart_list_view.dart';
import 'package:oua_flutter33/ui/chat_list/chat/chat_view.dart';
import 'package:oua_flutter33/ui/chat_list/chat_list_view.dart';
import 'package:oua_flutter33/ui/home/home_view.dart';
import 'package:oua_flutter33/ui/main/main_view.dart';
import 'package:oua_flutter33/ui/notification/notification_view.dart';
import 'package:oua_flutter33/ui/onboarding/onboarding_one/onboarding_one_view.dart';
import 'package:oua_flutter33/ui/onboarding/onboarding_two/onboarding_two_view.dart';
import 'package:oua_flutter33/ui/onboarding/onboarding_view.dart';
import 'package:oua_flutter33/ui/product/product-detail/product_view.dart';
import 'package:oua_flutter33/ui/product/product_add/product_add_view.dart';
import 'package:oua_flutter33/ui/profile/profile_view.dart';
import 'package:oua_flutter33/ui/profile/settings/settings_view.dart';
import 'package:oua_flutter33/ui/search/search_view.dart';
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
    MaterialRoute(page: ExampleView),
    MaterialRoute(page: NotificationView),
    MaterialRoute(page: ProfileView),
    MaterialRoute(page: SettingsView),
    MaterialRoute(page: SearchView),
    MaterialRoute(page: ChatListView),
    MaterialRoute(page: ChatView),
    MaterialRoute(page: ProductDetailView),
    MaterialRoute(page: ProductAddView),
    MaterialRoute(page: CartListView),
  ],
)
class App {}

//If you create route, this code 'flutter pub run build_runner build' is run in terminal