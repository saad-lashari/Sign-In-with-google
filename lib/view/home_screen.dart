import 'package:demoapp/google_sign_in/google_sign_in.dart';
import 'package:demoapp/view/send_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final con = Get.put(GoogleSignInController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                con.fetchMessages();
              },
              icon: const Icon(Icons.refresh)),
          IconButton(
              onPressed: () {
                con.signOut();
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
      body: ListView.builder(
          itemCount: con.mails.length,
          itemBuilder: (context, index) {
            return Card(child: ListTile(title: Text(con.mails[index])));
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const SendScreen());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
