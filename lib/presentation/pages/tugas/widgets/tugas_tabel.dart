import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr/core/theme.dart';

class TugasTabel extends StatelessWidget {
  const TugasTabel({super.key});
  final List<String> headers = const [
    "Judul",
    "Kepada",
    "Batas",
    "Jam Mulai",
    "Jam Diterima",
    "Status",
    "Selesai",
  ];

  final List<String> values = const [
    "Perbaikan Tesla, Perbaikan Tesla, Perbaikan Tesla, Perbaikan Tesla",
    "Elon Musk",
    "20/10/2025",
    "08 : 00",
    "17 : 00",
    "2",
    "N / A",
  ];
  Widget buildValueCell(BuildContext context, String value, int index) {
    if (index == 0) {
      String displayText =
          value.length > 10 ? value.substring(0, 15) + "..." : value;

      return GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: AppColors.primary, // background sesuai tema
              title: Text(
                "Detail Judul",
                style: TextStyle(
                  color: AppColors.putih, // warna teks judul tema kamu
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              content: Text(
                value,
                style: TextStyle(
                  color: AppColors.putih, // warna teks konten sesuai tema
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontSize: 16,
                ),
              ),
              actions: [
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.putih, // warna teks tombol
                  ),
                  child: const Text("Tutup"),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          );
        },
        child: Text(
          displayText,
          style: TextStyle(
            color: AppColors.putih,
            fontFamily: GoogleFonts.poppins().fontFamily,
            decoration: TextDecoration.underline,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }

    // index 5 status tetap sama
    if (index == 5) {
      String statusText;
      Color bgColor;

      switch (value) {
        case "0":
          statusText = "On Progress";
          bgColor = Colors.orange;
          break;
        case "1":
          statusText = "Completed";
          bgColor = Colors.green;
          break;
        case "2":
          statusText = "Rejected";
          bgColor = Colors.red;
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
        color: AppColors.putih,
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.02,
        vertical: MediaQuery.of(context).size.height * 0.01,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(56, 5, 5, 5),
              blurRadius: 5,
              offset: Offset(0, 1),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: false,
                      onChanged: (value) {},
                      side: BorderSide(color: AppColors.putih),
                      checkColor: AppColors.hitam,
                      activeColor: AppColors.putih,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '123', // No ID absen
                      style: TextStyle(
                          color: AppColors.putih,
                          fontFamily: GoogleFonts.poppins().fontFamily),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: FaIcon(FontAwesomeIcons.eye,
                          color: AppColors.putih, size: 20),
                      onPressed: () {},
                      iconSize: 20,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width *
                            0.02), // jarak proporsional
                    IconButton(
                      icon: FaIcon(FontAwesomeIcons.trash,
                          color: AppColors.putih, size: 20),
                      onPressed: () {},
                      iconSize: 20,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                    IconButton(
                      icon: FaIcon(FontAwesomeIcons.pen,
                          color: AppColors.putih, size: 20),
                      onPressed: () {},
                      iconSize: 16,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                )
              ],
            ),
            Align(
              alignment: Alignment.center,
              child: FractionallySizedBox(
                widthFactor: 1.09, // lebih dari 1 = lebar penuh + lebih
                child: Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // 🔽 Bagian Tabel Isi
            ListView.separated(
              shrinkWrap: true,
              physics:
                  const NeverScrollableScrollPhysics(), // supaya ikut scroll luar
              itemCount: headers.length,
              separatorBuilder: (_, __) =>
                  Divider(color: Colors.grey, thickness: 1),
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
                              color: AppColors.putih,
                              fontWeight: FontWeight.bold,
                              fontFamily: GoogleFonts.poppins().fontFamily),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: buildValueCell(context, values[index], index),
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
}
