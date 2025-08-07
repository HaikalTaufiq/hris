import 'package:flutter/material.dart';
import 'package:hr/components/navigation/navbar.dart';
import 'package:hr/core/theme.dart';
import 'package:hr/presentation/pages/absen/absen_page.dart';
import 'package:hr/presentation/pages/cuti/cuti_page.dart';
import 'package:hr/presentation/pages/dashboard/dashboard_page.dart';
import 'package:hr/presentation/pages/lembur/lembur_page.dart';
import 'package:hr/presentation/pages/tugas/tugas_page.dart';

class MainLayout extends StatefulWidget {
  final String nama;
  final String peran;

  const MainLayout({
    super.key,
    required this.nama,
    required this.peran,
  });

  @override
  State<MainLayout> createState() => _MainLayoutState();
}


class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      DashboardPage(nama: widget.nama, peran: widget.peran),
      AbsenPage(),
      TugasPage(),
      LemburPage(),
      CutiPage(),
    ];
  }


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
