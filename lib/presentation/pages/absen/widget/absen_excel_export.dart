import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr/core/theme.dart';

class AbsenExcelExport extends StatelessWidget {
  const AbsenExcelExport({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.02,
        vertical: MediaQuery.of(context).size.height * 0.0051,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 155,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: primary,
            ),
            child: Padding(
              padding: const EdgeInsets.all(9.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Start Date',
                          style: TextStyle(
                            color: putih,
                            fontSize: 12,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontWeight: FontWeight.w600,
                          )),
                      Text('dd/mm/yyyy',
                          style: TextStyle(
                            color: putih,
                            fontSize: 10,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontWeight: FontWeight.w300,
                          )),
                    ],
                  ),
                  FaIcon(FontAwesomeIcons.calendar, color: putih, size: 20),
                ],
              ),
            ),
          ),
          Container(
            width: 155,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: primary,
            ),
            child: Padding(
              padding: const EdgeInsets.all(9.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('End Date',
                          style: TextStyle(
                            color: putih,
                            fontSize: 12,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontWeight: FontWeight.w600,
                          )),
                      Text('dd/mm/yyyy',
                          style: TextStyle(
                            color: putih,
                            fontSize: 10,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontWeight: FontWeight.w300,
                          )),
                    ],
                  ),
                  FaIcon(FontAwesomeIcons.calendar, color: putih, size: 20),
                ],
              ),
            ),
          ),
          Container(
            width: 48,
            height: 48,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                backgroundColor: secondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const FaIcon(FontAwesomeIcons.download,
                  size: 20, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
