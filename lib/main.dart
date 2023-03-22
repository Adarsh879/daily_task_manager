import 'package:daily_task_manager/app.dart';
import 'package:daily_task_manager/screens/login.dart';
import 'package:daily_task_manager/screens/signup/sign_up_with_email.dart';
import 'package:daily_task_manager/screens/signup/signup_screen_first.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
