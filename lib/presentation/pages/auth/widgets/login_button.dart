import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:hr/presentation/layouts/main_layout.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainLayout()),
        );
      },
      child: Container(
        width: screenWidth * 0.85,
        height: 60,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(19, 33, 75, 1),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              offset: const Offset(2, 2),
              blurRadius: 5,
            ),
          ],
        ),
        child: Center(
          child: Text(
            'Log in',
            style: TextStyle(
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontSize: 14,
              color: const Color.fromRGBO(224, 224, 224, 1),
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
