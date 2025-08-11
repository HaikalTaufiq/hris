import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr/core/theme.dart';

class PeranAksesSearch extends StatelessWidget {
  const PeranAksesSearch({super.key});

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
          // TextField Flexible
          Expanded(
              child: TextField(
            cursorColor: AppColors.putih, // warna kursor
            style: TextStyle(color: AppColors.putih), // warna teks yg diketik
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 15),

              hintText: 'Search...',
              hintStyle: TextStyle(
                  color: AppColors.putih.withOpacity(0.5),
                  fontFamily:
                      GoogleFonts.poppins().fontFamily), // warna placeholder
              filled: true,
              fillColor: AppColors.primary, // background textfield
              suffixIcon: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: FaIcon(FontAwesomeIcons.magnifyingGlass,
                    color: AppColors.putih.withOpacity(0.5)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide:
                    BorderSide(color: AppColors.primary), // border normal
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                    color: AppColors.grey), // border saat hover/focus
              ),
            ),
          )),

          const SizedBox(width: 8),

          // Tombol Filter 1
          Container(
            width: buttonSize,
            height: buttonSize,
            child: ElevatedButton(
              onPressed: () {},
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
                  ..rotateZ(1.5708) // rotasi 90 derajat
                  ..scale(-1.0, 1.0), // reverse horizontal
                child: FaIcon(
                  FontAwesomeIcons.arrowRightArrowLeft,
                  size: 20,
                  color: AppColors.putih,
                ),
              ),
            ),
          ),

          const SizedBox(width: 8),

          // Tombol Filter 2
          Container(
            width: buttonSize,
            height: buttonSize,
            child: ElevatedButton(
              onPressed: () {},
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
