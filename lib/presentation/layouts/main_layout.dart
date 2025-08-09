import 'package:flutter/material.dart';
import 'package:hr/components/navigation/navbar.dart';
import 'package:hr/core/theme.dart';
import 'package:hr/presentation/dashboard_menu/departemen/departemen_page.dart';
import 'package:hr/presentation/dashboard_menu/gaji/gaji_page.dart';
import 'package:hr/presentation/dashboard_menu/jabatan/jabatan_page.dart';
import 'package:hr/presentation/dashboard_menu/karyawan/karyawan_page.dart';
import 'package:hr/presentation/dashboard_menu/log_aktivitas/log_page.dart';
import 'package:hr/presentation/dashboard_menu/pengaturan/pengaturan_page.dart';
import 'package:hr/presentation/dashboard_menu/peran_akses/peran_akses_page.dart';
import 'package:hr/presentation/dashboard_menu/tentang/tentang_page.dart';
import 'package:hr/presentation/pages/absen/absen_page.dart';
import 'package:hr/presentation/pages/cuti/cuti_page.dart';
import 'package:hr/presentation/pages/dashboard/dashboard_page.dart';
import 'package:hr/presentation/pages/lembur/lembur_page.dart';
import 'package:hr/presentation/pages/tugas/tugas_page.dart';

class MainLayout extends StatefulWidget {
  final int? initialIndex; // untuk halaman navbar
  final int? externalPageIndex; // untuk halaman luar navbar
  const MainLayout({super.key, this.initialIndex, this.externalPageIndex});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  late int _selectedIndex = 0;

  final List<Widget> _pages = const [
    DashboardPage(), // index 0
    AbsenPage(), // index 1
    TugasPage(), // index 2
    LemburPage(), // index 3
    CutiPage(), // index 4
  ];

  final List<Widget> _externalPages = const [
    KaryawanPage(), // index 0 di external
    GajiPage(), // index 1 di external
    DepartemenPage(), // index 2 di external
    JabatanPage(), // index 3 di external
    PeranAksesPage(), // index 4 di external
    TentangPage(), // index 5 di external
    LogPage(), // index 6 di external
    PengaturanPage(), // index 7 di external
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex ?? 0;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isExternal = widget.externalPageIndex != null;
    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: isExternal
            ? _externalPages[widget.externalPageIndex!]
            : _pages[_selectedIndex],
      ),
      bottomNavigationBar: NavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: (int index) {
          if (isExternal) {
            // jika lagi di external, pindah ke halaman nav
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => MainLayout(initialIndex: index),
              ),
            );
          } else {
            _onItemTapped(index);
          }
        },
      ),
    );
  }
}
