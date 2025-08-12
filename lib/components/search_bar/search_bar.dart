import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr/core/theme.dart';

class SearchingBar extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final VoidCallback? onFilter1Tap;
  final VoidCallback? onFilter2Tap;
  final ValueChanged<String>? onChanged;

  const SearchingBar({
    super.key,
    required this.controller, // wajib diisi dari luar
    this.hintText = 'Search...',
    this.onFilter1Tap,
    this.onFilter2Tap,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    const double buttonSize = 48;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.02,
        vertical: MediaQuery.of(context).size.height * 0.01,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller, // ← pakai controller dari luar
              cursorColor: AppColors.putih,
              style: TextStyle(color: AppColors.putih),
              onChanged: onChanged,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                hintText: hintText,
                hintStyle: TextStyle(
                  color: AppColors.putih.withOpacity(0.5),
                  fontFamily: GoogleFonts.poppins().fontFamily,
                ),
                filled: true,
                fillColor: AppColors.primary,
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: FaIcon(
                    FontAwesomeIcons.magnifyingGlass,
                    color: AppColors.putih.withOpacity(0.5),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: AppColors.primary),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: AppColors.grey),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: buttonSize,
            height: buttonSize,
            child: ElevatedButton(
              onPressed: onFilter1Tap,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                backgroundColor: AppColors.secondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..rotateZ(1.5708)
                  ..scale(-1.0, 1.0),
                child: FaIcon(
                  FontAwesomeIcons.arrowRightArrowLeft,
                  size: 20,
                  color: AppColors.putih,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: buttonSize,
            height: buttonSize,
            child: ElevatedButton(
              onPressed: onFilter2Tap,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                backgroundColor: AppColors.secondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: FaIcon(
                FontAwesomeIcons.sliders,
                size: 20,
                color: AppColors.putih,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
