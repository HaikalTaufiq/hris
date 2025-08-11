import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hr/core/header.dart';
import 'package:hr/data/models/tugas_model.dart';
import 'package:hr/data/services/tugas_service.dart';
import 'package:hr/presentation/pages/tugas/tugas_form/tugas_form.dart';
import 'package:hr/presentation/pages/tugas/widgets/tugas_search.dart';
import 'package:hr/presentation/pages/tugas/widgets/tugas_tabel.dart';

class TugasPage extends StatefulWidget {
  const TugasPage({super.key});

  @override
  State<TugasPage> createState() => _TugasPageState();
}
class _TugasPageState extends State<TugasPage> {
  late Future<List<TugasModel>> tugasFuture;

  @override
  void initState() {
    super.initState();
    tugasFuture = TugasService.fetchTugas();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Header(title: 'Manajemen Tugas'),
            const TugasSearch(),

            // TugasTabel sekarang kita ganti dengan FutureBuilder
            FutureBuilder<List<TugasModel>>(
              future: tugasFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text('Data tugas kosong');
                } else {
                  // Kirim data tugas ke widget TugasTabel
                  return TugasTabel(tugasList: snapshot.data!);
                }
              },
            ),
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
