import 'package:flutter/material.dart';

/// Scaler allows you to set the width and height of the widget in percentage
/// You can set the width of the Widget in the range of ( 0 to 1 )
/// 0.5 represent the  5%
/// 1.5 represent the 15%
/// same as above you have to set its value between ( 0 to 1 ) to set in
/// percentage
class Scaler extends StatelessWidget {
  const Scaler({super.key});

  /// This method is used to set the width in percentage
  static double width(double width, BuildContext context) {
    return MediaQuery.of(context).size.width * width;
  }

  /// This method is used to set the height in percentage
  static double height(double height, BuildContext context) {
    return MediaQuery.of(context).size.height * height;
  }

  /// This method is used to get device width
  static double getDeviceWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  /// This method is used to get device height
  static double getDeviceHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}