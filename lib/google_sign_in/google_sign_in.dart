import 'dart:developer';

import 'package:demoapp/view/auth_screen.dart';
import 'package:demoapp/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GoogleSignInController extends GetxController {
  List<String> mails = [];
  late GoogleSignInAccount? user;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'https://mail.google.com/'],
  );

  final http.Client _httpClient = http.Client();

  @override
  void onClose() {
    _httpClient.close();
    super.onClose();
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    Get.to(() => AuthScreen());
  }

  Future<void> signIn() async {
    user = await _googleSignIn.signIn();
    if (user != null) {
      Get.to(() => HomeScreen());
    }
  }

  Future<void> fetchMessages() async {
    if (user == null) {
      debugPrint('User not signed in.');
      return;
    }

    final Uri uri =
        Uri.https('www.googleapis.com', '/gmail/v1/users/me/messages');
    final http.Response response = await _httpClient.get(
      uri,
      headers: await user!.authHeaders,
    );

    if (response.statusCode == 200) {
      log('message');
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> messages = data['messages'];
      final List<String> parsedMessages = await _parseMessages(messages);
      mails = parsedMessages;
    } else {
      debugPrint('Failed to fetch messages: ${response.statusCode}');
    }
  }

  Future<List<String>> _parseMessages(List<dynamic> messages) async {
    final List<String> parsedMessages = [];
    for (var message in messages) {
      final messageUri = Uri.https(
          'www.googleapis.com', '/gmail/v1/users/me/messages/${message['id']}');
      final messageResponse = await _httpClient.get(
        messageUri,
        headers: await user!.authHeaders,
      );
      final Map<String, dynamic> messageData = jsonDecode(messageResponse.body);
      final String snippet = messageData['snippet'];
      parsedMessages.add(snippet);
    }
    return parsedMessages;
  }

  Future<void> sendMessage(Mail mail) async {
    if (user == null) {
      print('User not signed in.');
      return;
    }

    // Check if the recipient address is provided
    if (mail.recipient.isEmpty) {
      print('Recipient address is required.');
      return;
    }

    final String encodedMessage = _createMessage(
      user!.email,
      mail.recipient,
      mail.subject,
      mail.body,
    );

    // Send the message
    final Uri uri =
        Uri.https('www.googleapis.com', '/gmail/v1/users/me/messages/send');
    final http.Response response = await _httpClient.post(
      uri,
      headers: await user!.authHeaders,
      body: jsonEncode({'raw': encodedMessage}),
    );

    if (response.statusCode == 200) {
      Get.snackbar(
        'Sent',
        'Message sent successfully.',
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
      );
    } else {
      print('Failed to send message: ${response.body}');
      // Display an error message to the user
      Get.snackbar(
        'Error',
        'Failed to send message. Please try again later.',
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
      );
    }
  }

  String _createMessage(
      String sender, String recipient, String subject, String body) {
    final String encodedSubject = base64Url.encode(utf8.encode(subject));
    final String encodedBody = base64Url.encode(utf8.encode(body));
    final String message = '''
  From: $sender
  To: $recipient
  Subject: $encodedSubject
  Content-Type: text/html; charset="UTF-8"

  $encodedBody
  ''';
    return base64Url.encode(utf8.encode(message));
  }
}

class Mail {
  String recipient; // Replace with the recipient's email address
  String subject;
  String body;
  Mail({required this.recipient, required this.subject, required this.body});
}
