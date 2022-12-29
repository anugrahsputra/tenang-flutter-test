import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InboxPage extends StatelessWidget {
  const InboxPage({Key? key}) : super(key: key);
  static const routeName = '/inboxPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inbox'),
      ),
      body: Center(
        child: Text(
          'Your Inbox is empty',
          style: GoogleFonts.roboto(fontSize: 20),
        ),
      ),
    );
  }
}
