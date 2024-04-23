import 'package:demoapp/google_sign_in/google_sign_in.dart';
import 'package:demoapp/view/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: MyBingdings(),
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: AuthScreen(),
    );
  }
}

class MyBingdings extends Bindings {
  @override
  void dependencies() {
    Get.put(GoogleSignInController());
  }
}
