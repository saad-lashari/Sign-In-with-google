import 'package:demoapp/google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SendScreen extends StatefulWidget {
  const SendScreen({Key? key}) : super(key: key);

  @override
  State<SendScreen> createState() => _SendScreenState();
}

class _SendScreenState extends State<SendScreen> {
  final recipientController = TextEditingController();
  final subjectController = TextEditingController();
  final bodyController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final con = Get.put(GoogleSignInController());

  String? validateRecipient(String? value) {
    if (value == null || value.isEmpty) {
      return 'Recipient email is required';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? validateSubject(String? value) {
    if (value == null || value.isEmpty) {
      return 'Subject is required';
    }
    // You can add more complex validation here if needed
    return null;
  }

  String? validateBody(String? value) {
    if (value == null || value.isEmpty) {
      return 'Body is required';
    }
    // You can add more complex validation here if needed
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'abc@gmail.com',
                    border: OutlineInputBorder(),
                  ),
                  controller: recipientController,
                  validator: validateRecipient,
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'subject',
                    border: OutlineInputBorder(),
                  ),
                  controller: subjectController,
                  validator: validateSubject,
                ),
                SizedBox(height: 10),
                TextFormField(
                  maxLines: 4,
                  decoration: const InputDecoration(
                    hintText: 'body',
                    border: OutlineInputBorder(),
                  ),
                  controller: bodyController,
                  validator: validateBody,
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      con.sendMessage(Mail(
                          recipient: recipientController.text,
                          subject: subjectController.text,
                          body: bodyController.text));
                    }
                  },
                  child: Text('Send'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
