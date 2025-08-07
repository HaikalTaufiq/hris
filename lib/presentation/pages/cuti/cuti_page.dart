import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hr/presentation/pages/cuti/cuti_form/cuti_form.dart';
import 'package:hr/presentation/pages/cuti/widgets/cuti_card.dart';
import 'package:hr/presentation/pages/cuti/widgets/cuti_header.dart';
import 'package:hr/presentation/pages/cuti/widgets/cuti_search.dart';

class CutiPage extends StatefulWidget {
  const CutiPage({super.key});

  @override
  State<CutiPage> createState() => _CutiPageState();
}

class _CutiPageState extends State<CutiPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.all(16),
          children: [
            CutiHeader(),
            CutiSearch(),
            CutiCard(),
            CutiCard(),
            CutiCard(),
            CutiCard(),
            CutiCard(),
            CutiCard(),
          ],
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const CutiForm()),
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
