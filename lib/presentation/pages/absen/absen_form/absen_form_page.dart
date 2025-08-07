import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr/core/theme.dart';
import 'package:hr/presentation/pages/absen/absen_form/widgets/absen_input.dart';

class AbsenFormPage extends StatefulWidget {
  const AbsenFormPage({super.key});

  @override
  State<AbsenFormPage> createState() => _AbsenFormPageState();
}

class _AbsenFormPageState extends State<AbsenFormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        title: Text(
          'Form Absen',
          style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.poppins().fontFamily),
        ),
        backgroundColor: bg,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios), // atau CupertinoIcons.back
          color: Colors.white,
          onPressed: () => Navigator.of(context).pop(),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white, // warna ikon back
        ),
      ),
      body: ListView(children: [
        AbsenInput(),
      ]),
    );
  }
}
