import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr/core/theme.dart';
import 'package:hr/data/models/tugas_model.dart';

class TugasTabel extends StatelessWidget {
  final List<TugasModel> tugasList;

  const TugasTabel({super.key, required this.tugasList});

  final List<String> headers = const [
    "Judul",
    "Kepada",
    "Jam Mulai",
    "Tanggal Mulai",
    "Batas Tanggal Penyelesaian",
    "Lokasi",
    "Note",
    "Status",
  ];

  Widget buildValueCell(String value, int index) {
    if (index == 7) {  // status ada di index 7
      String statusText;
      Color bgColor;

      switch (value) {
        case 'Selesai':
          statusText = "Selesai";
          bgColor = Colors.green;
          break;
        case 'Proses':
          statusText = "Proses";
          bgColor = Colors.orange;
          break;
        default:
          statusText = "Unknown";
          bgColor = Colors.grey;
      }

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: bgColor, width: 1),
        ),
        child: Row(
          children: [
            const SizedBox(width: 4),
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: bgColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              statusText,
              style: TextStyle(
                color: bgColor,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
            ),
          ],
        ),
      );
    }

    return Text(
      value,
      style: TextStyle(
        color: Colors.white,
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    if (tugasList.isEmpty) {
      return const Center(
        child: Text('Belum ada tugas', style: TextStyle(color: Colors.white)),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: tugasList.length,
      itemBuilder: (context, tugasIndex) {
        final tugas = tugasList[tugasIndex];
        final List<String> values = [
          tugas.nama_tugas,
          tugas.user?.nama ?? 'Unknown',
          tugas.jam_mulai,
          tugas.tanggal_mulai,
          tugas.tanggal_selesai,
          tugas.lokasi,
          tugas.note,
          tugas.status,
        ];

        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Container(
            decoration: BoxDecoration(
              color: primary,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header bar with actions
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: false,
                          onChanged: (value) {},
                          side: const BorderSide(color: Colors.white),
                          checkColor: Colors.black,
                          activeColor: Colors.white,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${tugas.user?.departemen?.nama_departemen ?? 'Unknown'}',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const FaIcon(FontAwesomeIcons.eye, color: Colors.white, size: 20),
                          onPressed: () {},
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                        IconButton(
                          icon: const FaIcon(FontAwesomeIcons.trash, color: Colors.white, size: 20),
                          onPressed: () {},
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                        IconButton(
                          icon: const FaIcon(FontAwesomeIcons.pen, color: Colors.white, size: 20),
                          onPressed: () {},
                        ),
                      ],
                    )
                  ],
                ),
                Align(
                  alignment: Alignment.center,
                  child: FractionallySizedBox(
                    widthFactor: 1.09,
                    child: Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // Detail table
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: headers.length,
                  separatorBuilder: (_, __) => const Divider(color: Colors.grey, thickness: 1),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              headers[index],
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: buildValueCell(values[index], index),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      }

    );
  }
}
