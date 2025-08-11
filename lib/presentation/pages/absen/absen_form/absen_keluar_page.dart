import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr/core/theme.dart';
import 'package:hr/presentation/pages/absen/absen_form/widgets/input_out.dart';

class AbsenKeluarPage extends StatefulWidget {
  const AbsenKeluarPage({super.key});

  @override
  State<AbsenKeluarPage> createState() => _AbsenKeluarPageState();
}

class _AbsenKeluarPageState extends State<AbsenKeluarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        title: Text(
          'Form Absen Keluar',
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
        InputOut(),
      ]),
    );
  }
}
