import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr/core/theme.dart';

class DashboardCard extends StatelessWidget {
  const DashboardCard({super.key});

  // Example card data
  final List<Map<String, dynamic>> cardData = const [
    {
      'title': 'Employee Total',
      'value': '30',
      'icon': FontAwesomeIcons.users,
    },
    {
      'title': 'Departments',
      'value': '5',
      'icon': FontAwesomeIcons.building,
    },
    {
      'title': 'Active Projects',
      'value': '12',
      'icon': FontAwesomeIcons.tasks,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: max(130, MediaQuery.of(context).size.height * 0.15),
      child: PageView.builder(
        itemCount: cardData.length,
        controller: PageController(
          viewportFraction: 0.9,
        ),
        itemBuilder: (context, index) {
          final data = cardData[index];
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.01,
              vertical: MediaQuery.of(context).size.height * 0.02,
            ),
            child: Container(
              width: 355,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: primary,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data['title'],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          color: putih,
                        ),
                      ),
                      Text(
                        data['value'],
                        style: TextStyle(
                          fontSize: 25,
                          color: putih,
                          fontWeight: FontWeight.w900,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                        ),
                      ),
                    ],
                  ),
                  FaIcon(data['icon'], color: putih, size: 35),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
