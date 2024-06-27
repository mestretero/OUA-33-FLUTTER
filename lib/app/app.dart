
import 'package:oua_flutter33/ui/home/home_view.dart';
import 'package:oua_flutter33/ui/main/main_view.dart';
import 'package:oua_flutter33/ui/splash/splash_view.dart';
import 'package:stacked/stacked_annotations.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: SplashView, initial: true),
    MaterialRoute(page: MainView),
    MaterialRoute(page: HomeView),
  ],
)
class App {}