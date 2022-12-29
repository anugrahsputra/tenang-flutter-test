import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppointmentPage extends StatelessWidget {
  const AppointmentPage({Key? key}) : super(key: key);
  static const routeName = '/appointmentPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointment'),
      ),
      body: Center(
        child: Text(
          'You do not have any appointment',
          style: GoogleFonts.roboto(fontSize: 20),
        ),
      ),
    );
  }
}
