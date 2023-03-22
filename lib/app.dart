import 'package:daily_task_manager/controller/auth_controller.dart';
import 'package:daily_task_manager/controller/form_controllers/login_form_controller.dart';
import 'package:daily_task_manager/controller/form_controllers/login_form_controller.dart';
import 'package:daily_task_manager/controller/form_controllers/signup_form_controller.dart';
import 'package:daily_task_manager/screens/add_task.dart';
import 'package:daily_task_manager/screens/dashboard/dashboard.dart';
import 'package:daily_task_manager/screens/login.dart';
import 'package:daily_task_manager/screens/signup/sign_up_with_email.dart';
import 'package:daily_task_manager/screens/signup/signup_screen_first.dart';
import 'package:daily_task_manager/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'MyApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      defaultTransition: Transition.rightToLeft,
      getPages: [
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/signup1', page: () => SignUpScreenFirst()),
        GetPage(name: '/signup2', page: () => SignUpEmail()),
        GetPage(name: '/dashboard', page: () => DashBoard()),
        GetPage(name: '/addTask', page: () => AddTaskScreen()),
      ],
      initialBinding: BindingsBuilder(() {
        Get.lazyPut(() => AuthController());
      }),
      home: FutureBuilderBinder(),
    );
  }
}

class FutureBuilderBinder extends StatelessWidget {
  FutureBuilderBinder({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find<AuthController>();
    return FutureBuilder(
      future: authController.userStream.first,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SplashScreen();
        } else {
          if (authController.user.value != null && snapshot.data != null) {
            return DashBoard();
          } else {
            return LoginPage();
          }
        }
      },
    );
  }
}
