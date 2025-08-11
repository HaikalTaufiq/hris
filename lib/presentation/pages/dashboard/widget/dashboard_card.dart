import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr/core/theme.dart';

class DashboardCard extends StatelessWidget {
  const DashboardCard({super.key});

  final List<Map<String, dynamic>> cardData = const [
    {
      'title': 'Employee Total',
      'value': '30',
      'icon': "assets/images/3.png",
    },
    {
      'title': 'Departments',
      'value': '5',
      'icon': "assets/images/2.png",
    },
    {
      'title': 'Active Projects',
      'value': '12',
      'icon': "assets/images/1.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: max(130, MediaQuery.of(context).size.height * 0.12),
      child: PageView.builder(
        itemCount: cardData.length,
        controller: PageController(viewportFraction: 0.9),
        itemBuilder: (context, index) {
          final data = cardData[index];

          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.015,
              vertical: MediaQuery.of(context).size.height * 0.015,
            ),
            child: Stack(
              children: [
                // Container utama
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16), // padding khusus teks
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          data['title'],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            color: AppColors.putih,
                          ),
                        ),
                        Text(
                          data['value'],
                          style: TextStyle(
                            fontSize: 25,
                            color: AppColors.putih,
                            fontWeight: FontWeight.w900,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Gambar nempel ke bawah container
                Positioned(
                  bottom: -10,
                  right: 10,
                  child: SizedBox(
                    height:
                        max(130, MediaQuery.of(context).size.height * 0.12) *
                            0.9,
                    child: Image.asset(
                      data['icon'],
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
