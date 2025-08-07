import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hr/presentation/pages/lembur/lembur_form/lembur_form.dart';
import 'package:hr/presentation/pages/lembur/widgets/lembur_card.dart';
import 'package:hr/presentation/pages/lembur/widgets/lembur_header.dart';
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
            LemburHeader(),
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
            backgroundColor: Colors.black,
            shape: const CircleBorder(),
            child: const FaIcon(FontAwesomeIcons.plus, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
