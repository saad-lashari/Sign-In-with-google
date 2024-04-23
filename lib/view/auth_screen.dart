import 'package:demoapp/google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({super.key});
  final con = Get.put(GoogleSignInController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              con.signIn();
            },
            child: const Text('Sign in with google ')),
      ),
    );
  }
}
