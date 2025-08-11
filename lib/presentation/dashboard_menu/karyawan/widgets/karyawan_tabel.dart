import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr/core/theme.dart';

class KaryawanTabel extends StatelessWidget {
  const KaryawanTabel({super.key});

  final List<String> headers = const [
    "Nama",
    "Jabatan",
    "Peran",
    "Departemen",
    "Gaji Pokok",
    "Status Nikah ",
  ];

  final List<String> values = const [
    "Elon Musk",
    "Senior Developer",
    "Tech Lead",
    "Software Engineering",
    "Rp 20.000.000",
    "Married",
  ];

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
                      checkColor: Colors.black,
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
                  color: AppColors.secondary,
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
                  Divider(color: AppColors.secondary, thickness: 1),
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
                        child: Text(
                          values[index],
                          style: TextStyle(
                              color: AppColors.putih,
                              fontFamily: GoogleFonts.poppins().fontFamily),
                        ),
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
