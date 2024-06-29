import 'package:flutter/material.dart';
import 'package:oua_flutter33/app/app_base_view_model.dart';

class ExampleViewModel extends AppBaseViewModel {
  init(BuildContext context) {}

  //Navigation Example
  /*
  For page transition, a view must first be added to the app.dart file. 
  After adding, the 'flutter pub run build_runner build --delete-conflicting-outputs' or
  'flutter pub run build_runner build' command should be run through the terminal.
  After the command, the app.router.dart file will be automatically recreated.
   */
  
  navigatePage() {
    // navigationService.navigateTo(Routes.exampleView);
  }
}
