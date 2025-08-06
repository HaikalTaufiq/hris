import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr/core/theme.dart';

class DashboardMenu extends StatelessWidget {
  const DashboardMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.04,
        vertical: MediaQuery.of(context).size.height * 0.0001,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Office Services",
            style: TextStyle(
              fontSize: 24,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontWeight: FontWeight.bold,
              color: putih,
            ),
          ),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 4,
            crossAxisSpacing: 12,
            mainAxisSpacing: 24,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(8, (index) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child:
                        const Icon(Icons.apps, size: 28, color: Colors.black),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Menu ${index + 1}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white, // ganti kalau perlu
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
