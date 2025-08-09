import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hr/core/header.dart';
import 'package:hr/presentation/dashboard_menu/peran_akses/peran_form/peran_form.dart';
import 'package:hr/presentation/dashboard_menu/peran_akses/widgets/peran_search.dart';
import 'package:hr/presentation/dashboard_menu/peran_akses/widgets/peran_tabel.dart';

class PeranAksesPage extends StatefulWidget {
  const PeranAksesPage({super.key});

  @override
  State<PeranAksesPage> createState() => _PeranAksesPageState();
}

class _PeranAksesPageState extends State<PeranAksesPage> {
  final List<bool> akses = List.generate(9, (_) => false);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.all(16),
          children: const [
            Header(title: 'Manajemen Peran & Akses'),
            PeranAksesSearch(),
            PeranTabel(),
          ],
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const PeranForm(),
                ),
              );
            },
            backgroundColor: Colors.black,
            shape: const CircleBorder(),
            child: const FaIcon(FontAwesomeIcons.plus, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
