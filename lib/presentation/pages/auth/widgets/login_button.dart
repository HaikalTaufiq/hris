// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr/data/services/auth_service.dart';
import 'package:hr/core/helpers/notification_helper.dart';
import 'package:hr/presentation/layouts/main_layout.dart';

class LoginButton extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginButton({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () async {
        final email = emailController.text.trim();
        final password = passwordController.text;

        final auth = AuthService();
        final result = await auth.login(email, password);

        if (result['success']) {
          NotificationHelper.showSnackBar(context, result['message'],
              isSuccess: true);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => MainLayout(),
            ),
          );
        } else {
          NotificationHelper.showSnackBar(context, result['message'],
              isSuccess: false);
        }
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
