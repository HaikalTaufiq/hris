import 'package:flutter/material.dart';
import 'package:hr/core/theme.dart';

class LemburPage extends StatefulWidget {
  const LemburPage({super.key});

  @override
  State<LemburPage> createState() => _LemburPageState();
}

class _LemburPageState extends State<LemburPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        Text("Lembur",
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: putih)),
        SizedBox(height: 16),
      ],
    );
  }
}
