import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr/core/theme.dart';
import 'package:hr/presentation/pages/tugas/tugas_form/widget/tugas_input.dart';

class TugasForm extends StatefulWidget {
  const TugasForm({super.key});

  @override
  State<TugasForm> createState() => _TugasFormState();
}

class _TugasFormState extends State<TugasForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        title: Text(
          'Tambahkan Tugas',
          style: TextStyle(
              color: AppColors.putih,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.poppins().fontFamily),
        ),
        backgroundColor: AppColors.bg,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios), // atau CupertinoIcons.back
          color: AppColors.putih,
          onPressed: () => Navigator.of(context).pop(),
        ),
        iconTheme: IconThemeData(
          color: AppColors.putih, // warna ikon back
        ),
      ),
      body: ListView(children: [
        TugasInput(),
      ]),
    );
  }
}
