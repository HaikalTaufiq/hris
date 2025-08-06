import 'package:flutter/material.dart';
import 'package:hr/core/theme.dart';

class AbsenPage extends StatefulWidget {
  const AbsenPage({super.key});

  @override
  State<AbsenPage> createState() => _AbsenPageState();
}

class _AbsenPageState extends State<AbsenPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        Text("Attendance",
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: putih)),
        SizedBox(height: 16),
        Card(
          child: ListTile(
            leading: Icon(Icons.check_circle_outline),
            title: Text("Status Kehadiran"),
            subtitle: Text("Belum absen hari ini"),
          ),
        ),
        // Tambah widget lain sesuai kebutuhan
      ],
    );
  }
}
