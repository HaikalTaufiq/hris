import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hr/core/header.dart';
import 'package:hr/presentation/pages/absen/absen_form/absen_keluar_page.dart';
import 'package:hr/presentation/pages/absen/absen_form/absen_masuk_page.dart';
import 'package:hr/presentation/pages/absen/widget/absen_excel_export.dart';
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
            Header(title: "Attendance Management"),
            AbsenSearch(),
            AbsenExcelExport(),
            AbsenTabel(),
            AbsenTabel(),
          ],
        ),

        // Floating Action Button
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Pilih Aksi"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.of(context).pop(); // tutup dialog dulu
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const AbsenMasukPage(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.login),
                          label: const Text("Check In"),
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.of(context).pop(); // tutup dialog dulu
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const AbsenKeluarPage(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.logout),
                          label: const Text("Check Out"),
                        ),
                      ],
                    ),
                  );
                },
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
