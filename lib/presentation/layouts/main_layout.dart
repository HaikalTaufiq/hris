import 'package:flutter/material.dart';
import 'package:hr/components/navigation/navbar.dart';
import 'package:hr/core/theme.dart';
import 'package:hr/presentation/pages/absen/absen_page.dart';
import 'package:hr/presentation/pages/cuti/cuti_page.dart';
import 'package:hr/presentation/pages/dashboard/dashboard_page.dart';
import 'package:hr/presentation/pages/lembur/lembur_page.dart';
import 'package:hr/presentation/pages/tugas/tugas_page.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    DashboardPage(), // index 0
    AbsenPage(), // index 1
    TugasPage(), // index 2
    LemburPage(), // index 3
    CutiPage(), // index 5
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: NavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
