// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oua_flutter33/app/app.router.dart';
import 'package:oua_flutter33/app/app_base_view_model.dart';
import 'package:oua_flutter33/core/di/get_it.dart';
import 'package:oua_flutter33/ui/main/main_view.dart';
import 'package:oua_flutter33/ui/splash/splash_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class MasterHandsApp extends StatelessWidget {
  const MasterHandsApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
    ]);

    return ViewModelBuilder<AppBaseViewModel>.reactive(
      viewModelBuilder: () => getIt<AppBaseViewModel>(),
      onModelReady: (viewModel) => viewModel.initialise(),
      builder: (context, viewModel, child) => MaterialApp(
        navigatorKey: StackedService.navigatorKey,
        onGenerateRoute: StackedRouter().onGenerateRoute,
        navigatorObservers: [StackedService.routeObserver],
        title: "Master Hands",
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: viewModel.authServices.getAuthStateChanges(),
          builder: (context, snapshot) =>
              snapshot.data != null ? const MainView() : const SplashView(),
        ),
      ),
    );
  }
}
