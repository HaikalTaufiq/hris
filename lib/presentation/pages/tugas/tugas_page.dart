import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hr/presentation/pages/tugas/tugas_form/tugas_form.dart';
import 'package:hr/presentation/pages/tugas/widgets/tugas_header.dart';
import 'package:hr/presentation/pages/tugas/widgets/tugas_search.dart';
import 'package:hr/presentation/pages/tugas/widgets/tugas_tabel.dart';

class TugasPage extends StatefulWidget {
  const TugasPage({super.key});

  @override
  State<TugasPage> createState() => _TugasPageState();
}

class _TugasPageState extends State<TugasPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.all(16),
          children: const [
            TugasHeader(),
            TugasSearch(),
            TugasTabel(),
            TugasTabel(),
            TugasTabel(),
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
                  builder: (context) => const TugasForm(),
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
