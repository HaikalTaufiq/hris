import 'package:flutter/material.dart';
import 'package:hr/core/theme.dart';

class TugasHeader extends StatelessWidget {
  const TugasHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.04,
        vertical: MediaQuery.of(context).size.height * 0.01,
      ),
      child: Text(
        'Daftar Tugas',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: putih,
        ),
      ),
    );
  }
}
