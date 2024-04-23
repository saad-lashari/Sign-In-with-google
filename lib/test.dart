// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class GmailScreen extends StatefulWidget {
//   const GmailScreen({super.key});

//   @override
//   GmailScreenState createState() => GmailScreenState();
// }

// class GmailScreenState extends State<GmailScreen> {
//   final GoogleSignIn _googleSignIn = GoogleSignIn(
//     scopes: [
//       'email',
//       'https://www.googleapis.com/auth/gmail.readonly',
//       'https://www.googleapis.com/auth/gmail.compose',
//       'https://www.googleapis.com/auth/gmail.send',
//       'https://www.googleapis.com/auth/gmail.modify'
//     ],
//   );

//   GoogleSignInAccount? _googleUser;
//   late http.Client _httpClient;

//   @override
//   void initState() {
//     super.initState();
//     _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
//       setState(() {
//         _googleUser = account;
//         if (_googleUser != null) {
//           _httpClient = http.Client();
//         }
//       });
//     });
//   }

//   Future<void> _fetchMessages() async {
//     if (_googleUser == null) {
//       print('User not signed in.');
//       return;
//     }

//     final Uri uri =
//         Uri.https('www.googleapis.com', '/gmail/v1/users/me/messages');
//     final http.Response response = await _httpClient.get(
//       uri,
//       headers: await _googleUser!.authHeaders,
//     );

//     if (response.statusCode == 200) {
//       final Map<String, dynamic> data = jsonDecode(response.body);
//       print('Messages: $data');
//     } else {
//       print('Failed to fetch messages: ${response.statusCode}');
//     }
//   }

//   Future<void> _sendMessage() async {
//     if (_googleUser == null) {
//       print('User not signed in.');
//       return;
//     }

//     // Implement sending message logic here
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Gmail Integration'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: _fetchMessages,
//               child: Text('Fetch Messages'),
//             ),
//             ElevatedButton(
//               onPressed: _sendMessage,
//               child: Text('Send Message'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _httpClient.close();
//     super.dispose();
//   }
// }
