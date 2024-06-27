import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:oua_flutter33/app/master_hands_app.dart';
import 'package:oua_flutter33/core/di/get_it.dart';
import 'package:oua_flutter33/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupDI();
  runApp(const MasterHandsApp());
}
