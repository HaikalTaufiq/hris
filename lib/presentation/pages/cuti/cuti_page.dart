import 'package:flutter/material.dart';
import 'package:hr/core/theme.dart';

class CutiPage extends StatefulWidget {
  const CutiPage({super.key});

  @override
  State<CutiPage> createState() => _CutiPageState();
}

class _CutiPageState extends State<CutiPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        Text("Cuti",
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: putih)),
        SizedBox(height: 16),
      ],
    );
  }
}
