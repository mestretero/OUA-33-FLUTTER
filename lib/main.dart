import 'package:flutter/material.dart';
import 'package:oua_flutter33/app/master_hands_app.dart';
import 'package:oua_flutter33/core/di/get_it.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupDI();
  runApp(const MasterHandsApp());
}
