import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr/core/theme.dart';
import 'package:hr/data/models/user_model.dart';

class KaryawanTabel extends StatelessWidget {
  final List<UserModel> users;

  const KaryawanTabel({super.key, required this.users});

  final List<String> headers = const [
    "Nama",
    "Email",
    "Peran",
    "Jabatan",
    "Departemen",
    "Gaji Pokok",
    "Jenis Kelamin",
    "Status Nikah",
    "NO. NPWP",
    "NO. BPJS TK",
    "NO. BPJS KES",
  ];

  void _showDetailDialog(BuildContext context, UserModel user) {
    final values = [
      user.nama,
      user.email,
      user.peran.namaPeran,
      user.jabatan?.namaJabatan ?? '-',
      user.departemen.namaDepartemen,
      user.gajiPokok ?? '-',
      user.jenisKelamin,
      user.statusPernikahan,
      user.npwp ?? '-',
      user.bpjsKetenagakerjaan ?? '-',
      user.bpjsKesehatan ?? '-',
    ];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.primary,
        title: Text(
          'Details',
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
    return Column(
      children: users.map((user) {
        final values = [
          user.nama,
          user.email,
          user.peran.namaPeran,
          user.jabatan?.namaJabatan ?? '-',
          user.departemen.namaDepartemen,
          user.gajiPokok ?? '-',
          user.jenisKelamin,
          user.statusPernikahan,
          user.npwp ?? '-',
          user.bpjsKetenagakerjaan ?? '-',
          user.bpjsKesehatan ?? '-',
        ];

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(56, 5, 5, 5),
                  blurRadius: 5,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
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
                          user.id.toString(),
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
                          onPressed: () => _showDetailDialog(context, user),
                        ),
                        IconButton(
                          icon: FaIcon(FontAwesomeIcons.trash,
                              color: AppColors.putih, size: 20),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: FaIcon(FontAwesomeIcons.pen,
                              color: AppColors.putih, size: 20),
                          onPressed: () {},
                        ),
                      ],
                    )
                  ],
                ),
                Divider(color: AppColors.secondary, thickness: 1),
                // Tampilkan semua field sesuai headers
                Column(
                  children: List.generate(headers.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              headers[index],
                              style: TextStyle(
                                  color: AppColors.putih,
                                  fontWeight: FontWeight.bold,
                                  fontFamily:
                                      GoogleFonts.poppins().fontFamily),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              values[index],
                              style: TextStyle(
                                  color: AppColors.putih,
                                  fontFamily:
                                      GoogleFonts.poppins().fontFamily),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
