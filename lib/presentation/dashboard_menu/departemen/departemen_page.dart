import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr/core/header.dart';
import 'package:hr/core/theme.dart';
import 'package:hr/presentation/dashboard_menu/departemen/widgets/department_search.dart';
import 'package:hr/presentation/dashboard_menu/departemen/widgets/department_tabel.dart';

class DepartemenPage extends StatefulWidget {
  const DepartemenPage({super.key});

  @override
  State<DepartemenPage> createState() => _DepartemenPageState();
}

class _DepartemenPageState extends State<DepartemenPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Header(title: 'Manajemen Departemen'),
            DepartmenSearch(),
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
                    backgroundColor: primary,
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
                                color: putih,
                                fontWeight: FontWeight.w600,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                              ),
                            ),
                            const SizedBox(height: 24),
                            TextField(
                              textAlign: TextAlign.center,
                              style: TextStyle(color: putih),
                              cursorColor: putih,
                              decoration: InputDecoration(
                                hintText: 'Nama Department',
                                hintStyle: TextStyle(
                                  color:
                                      const Color.fromARGB(164, 189, 189, 189),
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                  fontSize: 14,
                                ),
                                filled: true,
                                fillColor: secondary,
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
                                      backgroundColor: grey,
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
                                          color: putih,
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
                                      backgroundColor: blue,
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
                                          color: putih,
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
            backgroundColor: Colors.black,
            shape: const CircleBorder(),
            child: const FaIcon(FontAwesomeIcons.plus, color: Colors.white),
          ),
        )
      ],
    );
  }
}
