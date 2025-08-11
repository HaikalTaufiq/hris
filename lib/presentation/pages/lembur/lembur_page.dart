import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hr/core/header.dart';
import 'package:hr/core/theme.dart';
import 'package:hr/presentation/pages/lembur/lembur_form/lembur_form.dart';
import 'package:hr/presentation/pages/lembur/widgets/lembur_card.dart';
import 'package:hr/presentation/pages/lembur/widgets/lembur_search.dart';

class LemburPage extends StatefulWidget {
  const LemburPage({super.key});

  @override
  State<LemburPage> createState() => _LemburPageState();
}

class _LemburPageState extends State<LemburPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.all(16),
          children: const [
            Header(title: 'Pengajuan Lembur'),
            LemburSearch(),
            LemburCard(),
            LemburCard(),
            LemburCard(),
            LemburCard(),
            LemburCard(),
          ],
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const LemburForm()),
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
