import 'package:flutter/material.dart';
import 'package:hr/core/header.dart';
import 'package:hr/presentation/dashboard_menu/gaji/widgets/gaji_count.dart';
import 'package:hr/presentation/dashboard_menu/gaji/widgets/gaji_search.dart';
import 'package:hr/presentation/dashboard_menu/gaji/widgets/gaji_tabel.dart';

class GajiPage extends StatefulWidget {
  const GajiPage({super.key});

  @override
  State<GajiPage> createState() => _GajiPageState();
}

class _GajiPageState extends State<GajiPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        Header(title: 'Manajemen Gaji'),
        GajiSearch(),
        GajiCount(),
        GajiTabel(),
        GajiTabel(),
      ],
    );
  }
}
