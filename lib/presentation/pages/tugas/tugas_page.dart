import 'package:flutter/material.dart';
import 'package:hr/core/theme.dart';

class TugasPage extends StatefulWidget {
  const TugasPage({super.key});

  @override
  State<TugasPage> createState() => _TugasPageState();
}

class _TugasPageState extends State<TugasPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        Text("Task",
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: putih)),
        SizedBox(height: 16),
      ],
    );
  }
}
