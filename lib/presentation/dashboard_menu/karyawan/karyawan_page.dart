import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hr/core/header.dart';
import 'package:hr/core/theme.dart';
import 'package:hr/presentation/dashboard_menu/karyawan/karyawan_form/karyawan_form.dart';
import 'package:hr/presentation/dashboard_menu/karyawan/widgets/karyawan_search.dart';
import 'package:hr/presentation/dashboard_menu/karyawan/widgets/karyawan_tabel.dart';

class KaryawanPage extends StatefulWidget {
  const KaryawanPage({super.key});

  @override
  State<KaryawanPage> createState() => _KaryawanPageState();
}

class _KaryawanPageState extends State<KaryawanPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.all(16),
          children: const [
            Header(title: 'Manajemen Karyawan'),
            KaryawanSearch(),
            KaryawanTabel(),
            KaryawanTabel(),
            KaryawanTabel(),
          ],
        ),
        // Floating Action Button
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const KaryawanForm(),
                ),
              );
            },
            backgroundColor: AppColors.bg,
            shape: const CircleBorder(),
            child: FaIcon(FontAwesomeIcons.plus, color: AppColors.putih),
          ),
        ),
      ],
    );
  }
}
