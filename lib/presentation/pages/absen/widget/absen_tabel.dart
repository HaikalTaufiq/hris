import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr/core/theme.dart';

class AbsenTabel extends StatelessWidget {
  const AbsenTabel({super.key});

  final List<String> headers = const [
    "Nama",
    "Tanggal",
    "Tipe",
    "Jam Masuk",
    "Jam Keluar",
    "Lokasi",
    "Foto",
    "Keterangan",
  ];

  final List<String> values = const [
    "Elon Musk",
    "12 / 10 / 2025",
    "Clock In",
    "08 : 00",
    "17 : 00",
    "198.12039.1123",
    "See Photo",
    "jadi tadi telat dikit trus blablabla",
  ];

  void _showDetailDialog(BuildContext context, List<String> values) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.primary,
        title: Text(
          'Detail Absen',
          style: TextStyle(
            color: AppColors.putih,
            fontFamily: GoogleFonts.poppins().fontFamily,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(headers.length, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
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
                          fontFamily: GoogleFonts.poppins().fontFamily,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        values[index],
                        style: TextStyle(
                          color: AppColors.putih,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Tutup',
              style: TextStyle(
                color: AppColors.putih,
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
            ),
          ),
        ],
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
                      checkColor: Colors.black,
                      activeColor: Colors.white,
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
                      onPressed: () => _showDetailDialog(context, values),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                    IconButton(
                      icon: FaIcon(FontAwesomeIcons.trash,
                          color: AppColors.putih, size: 20),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(
                              'Hapus',
                              style: TextStyle(
                                color: AppColors.putih,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                              ),
                            ),
                            backgroundColor: AppColors.primary,
                            content: Text(
                              'Yakin mau hapus item ini?',
                              style: TextStyle(
                                color: AppColors.putih,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text(
                                  'Batal',
                                  style: TextStyle(
                                    color: AppColors.putih,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Hapus',
                                  style: TextStyle(
                                    color: AppColors.putih,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.02),
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
                  const Divider(color: Colors.grey, thickness: 1),
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
                        child: GestureDetector(
                          onTap: () {
                            _showDetailDialog(context, values);
                          },
                          child: Text(
                            index == 7 && values[index].length > 15
                                ? '${values[index].substring(0, 15)}...'
                                : values[index],
                            style: TextStyle(
                                color: AppColors.putih,
                                fontFamily: GoogleFonts.poppins().fontFamily),
                          ),
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
