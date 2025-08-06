import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hr/presentation/pages/absen/widget/absen_excel_export.dart';
import 'package:hr/presentation/pages/absen/widget/absen_header.dart';
import 'package:hr/presentation/pages/absen/widget/absen_search.dart';
import 'package:hr/presentation/pages/absen/widget/absen_tabel.dart';

class AbsenPage extends StatefulWidget {
  const AbsenPage({super.key});

  @override
  State<AbsenPage> createState() => _AbsenPageState();
}

class _AbsenPageState extends State<AbsenPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.all(16),
          children: [
            AbsenHeader(),
            AbsenSearch(),
            AbsenExcelExport(),
            AbsenTabel(),
          ],
        ),

        // Floating Action Button
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.black,
            shape: const CircleBorder(),
            child: const FaIcon(FontAwesomeIcons.plus, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
