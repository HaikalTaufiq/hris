import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr/components/custom/loading.dart';
import 'package:hr/components/search_bar/search_bar.dart';
import 'package:hr/core/header.dart';
import 'package:hr/data/models/tugas_model.dart';
import 'package:hr/data/services/tugas_service.dart';
import 'package:hr/core/theme.dart';
import 'package:hr/presentation/pages/tugas/tugas_form/tugas_form.dart';
import 'package:hr/presentation/pages/tugas/widgets/tugas_tabel.dart';

class TugasPage extends StatefulWidget {
  const TugasPage({super.key});

  @override
  State<TugasPage> createState() => _TugasPageState();
}

class _TugasPageState extends State<TugasPage> {
  late Future<List<TugasModel>> tugasFuture;
  final searchController = TextEditingController(); // value awal

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
            SearchingBar(
              controller: searchController,
              onChanged: (value) {
                print("Search Halaman A: $value");
              },
              onFilter1Tap: () => print("Filter1 Halaman A"),
              onFilter2Tap: () => print("Filter2 Halaman A"),
            ),
            // TugasTabel sekarang kita ganti dengan FutureBuilder
            FutureBuilder<List<TugasModel>>(
              future: tugasFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: const Center(
                      child: LoadingWidget(),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Center(
                        child: Text(
                      'Data tugas kosong',
                      style: TextStyle(
                        color: AppColors.putih,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                      ),
                    )),
                  );
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
            onPressed: () async {
              final result = await Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const TugasForm()),
              );

              if (result == true) {
                setState(() {
                  tugasFuture = TugasService.fetchTugas(); // refresh data
                });
              }
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
