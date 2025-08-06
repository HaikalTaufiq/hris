import 'package:flutter/material.dart';
import 'package:hr/core/theme.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        Text("Dashboard",
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
