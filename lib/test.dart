import 'package:googleapis/gmail/v1.dart';
import 'package:googleapis_auth/auth_io.dart';

Future<void> sendEmail(
    String recipientEmail, String subject, String body) async {
  final credentials = ServiceAccountCredentials.fromJson({
    'private_key': 'YOUR_PRIVATE_KEY',
    'client_email': 'YOUR_CLIENT_EMAIL',
  });

  final client =
      await clientViaServiceAccount(credentials, [GmailApi.mailGoogleComScope]);

  final gmail = GmailApi(client);
  final email = Message();

  try {
    await gmail.users.messages.send(email, 'me');
    // Email sent successfully
  } catch (error) {
    // Handle email sending errors
  }

  client.close();
}
