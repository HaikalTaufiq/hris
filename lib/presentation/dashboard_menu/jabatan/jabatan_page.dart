import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr/components/search_bar/search_bar.dart';
import 'package:hr/core/header.dart';
import 'package:hr/core/theme.dart';
import 'package:hr/presentation/dashboard_menu/jabatan/widgets/jabatan_tabel.dart';

class JabatanPage extends StatefulWidget {
  const JabatanPage({super.key});

  @override
  State<JabatanPage> createState() => _JabatanPageState();
}

class _JabatanPageState extends State<JabatanPage> {
  final searchController = TextEditingController(); // value awal

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Header(title: 'Manajemen Jabatan'),
            SearchingBar(
              controller: searchController,
              onChanged: (value) {
                print("Search Halaman A: $value");
              },
              onFilter1Tap: () => print("Filter1 Halaman A"),
              onFilter2Tap: () => print("Filter2 Halaman A"),
            ),
            JabatanTabel(),
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
                  return Dialog(
                    backgroundColor: AppColors.primary, // Latar belakang custom
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Tambah Jabatan',
                            style: TextStyle(
                              fontSize: 20,
                              color: AppColors.putih,
                              fontWeight: FontWeight.w600,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                            ),
                          ),
                          const SizedBox(height: 24),
                          TextField(
                            textAlign: TextAlign.center,
                            style: TextStyle(color: AppColors.putih),
                            cursorColor: AppColors.putih,
                            decoration: InputDecoration(
                              hintText: 'Nama Jabatan',
                              hintStyle: TextStyle(
                                color: AppColors.putih,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                                fontSize: 14,
                              ),
                              filled: true,
                              fillColor: AppColors.secondary,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 14,
                                horizontal: 20,
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.grey,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context); // Tutup dialog
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                    horizontal: 18,
                                  ),
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily:
                                          GoogleFonts.poppins().fontFamily,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12), // spasi antar tombol
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Jabatan submitted')),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                    horizontal: 18,
                                  ),
                                  child: Text(
                                    'Submit',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily:
                                          GoogleFonts.poppins().fontFamily,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            backgroundColor: AppColors.secondary,
            shape: const CircleBorder(),
            child: FaIcon(FontAwesomeIcons.plus, color: AppColors.putih),
          ),
        )
      ],
    );
  }
}
