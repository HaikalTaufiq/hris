import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr/core/theme.dart';
import 'package:hr/presentation/pages/absen/absen_form/widgets/input_in.dart';

class AbsenMasukPage extends StatefulWidget {
  const AbsenMasukPage({super.key});

  @override
  State<AbsenMasukPage> createState() => _AbsenMasukPageState();
}

class _AbsenMasukPageState extends State<AbsenMasukPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        title: Text(
          'Form Absen Masuk',
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
        InputIn(),
      ]),
    );
  }
}
