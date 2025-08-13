import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr/components/search_bar/search_bar.dart';
import 'package:hr/components/custom/header.dart';
import 'package:hr/core/theme.dart';
import 'package:hr/presentation/dashboard_menu/departemen/widgets/department_tabel.dart';

class DepartemenPage extends StatefulWidget {
  const DepartemenPage({super.key});

  @override
  State<DepartemenPage> createState() => _DepartemenPageState();
}

class _DepartemenPageState extends State<DepartemenPage> {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Header(title: 'Manajemen Departemen'),
            SearchingBar(
              controller: searchController,
              onChanged: (value) {
                print("Search Halaman A: $value");
              },
              onFilter1Tap: () => print("Filter1 Halaman A"),
              onFilter2Tap: () => print("Filter2 Halaman A"),
            ),
            DepartmentTabel(),
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
                  final screenHeight = MediaQuery.of(context).size.height;
                  final screenWidth = MediaQuery.of(context).size.width;

                  return Dialog(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight:
                            screenHeight * 0.8, // max 80% dari tinggi layar
                        maxWidth: screenWidth * 0.9, // max 90% dari lebar layar
                      ),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Tambah Department',
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
                                hintText: 'Nama Department',
                                hintStyle: TextStyle(
                                    color: AppColors.putih,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w100),
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
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.grey,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 14,
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
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.blue,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text('Department submitted'),
                                        ),
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 14,
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
                                ),
                              ],
                            ),
                          ],
                        ),
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
