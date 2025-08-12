// lib/core/helpers/notification_helper.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr/core/theme.dart';

class NotificationHelper {
  static void showSnackBar(
    BuildContext context,
    String message, {
    bool isSuccess = true,
    Duration duration = const Duration(seconds: 3),
  }) {
    final backgroundColor = isSuccess ? AppColors.green : AppColors.red;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
        ),
        backgroundColor: backgroundColor,
        duration: duration,
      ),
    );
  }
}
