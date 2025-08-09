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
        children: [
          // Start Date
          Expanded(
            child: _buildDateCard(
              title: 'Start Date',
              subtitle: 'dd/mm/yyyy',
              icon: FontAwesomeIcons.calendar,
            ),
          ),
          const SizedBox(width: 8),

          // End Date
          Expanded(
            child: _buildDateCard(
              title: 'End Date',
              subtitle: 'dd/mm/yyyy',
              icon: FontAwesomeIcons.calendar,
            ),
          ),
          const SizedBox(width: 8),

          // Calculate Button
          SizedBox(
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
              child: const FaIcon(
                FontAwesomeIcons.download,
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Widget untuk kartu tanggal
  Widget _buildDateCard({
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: primary,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Text bagian kiri
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: putih,
                  fontSize: 12,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  color: putih,
                  fontSize: 10,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),

          // Icon bagian kanan
          FaIcon(icon, color: putih, size: 20),
        ],
      ),
    );
  }
}
