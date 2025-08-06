import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr/core/theme.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.04,
          vertical: MediaQuery.of(context).size.height * 0.01,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: putih),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Elon Musk',
                        style: TextStyle(
                            fontSize: 24,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontWeight: FontWeight.bold,
                            color: putih)),
                    Text('Super Admin',
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            height: 0.8,
                            fontWeight: FontWeight.w400,
                            color: const Color.fromARGB(172, 224, 224, 224))),
                  ],
                ),
              ],
            ),
            FaIcon(FontAwesomeIcons.barsStaggered, color: putih, size: 25),
          ],
        ),
      ),
    );
  }
}
