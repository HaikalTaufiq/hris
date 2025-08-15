import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr/core/theme.dart';
import 'package:hr/data/models/dahsboard_menu_item.dart';
import 'package:provider/provider.dart';
import 'package:hr/provider/user_provider.dart';

class DashboardMenu extends StatelessWidget {
  final List<DashboardMenuItem> items;

  const DashboardMenu({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();

    double iconSize = MediaQuery.of(context).size.width * 0.07;
    double fontSize = MediaQuery.of(context).size.width * 0.028;

    // filter menu yang user punya akses
    final accessibleItems = items.where((item) {
      // kalau featureId null berarti semua bisa akses
      if (item.featureId == null) return true;
      return userProvider.hasFeature(item.featureId!);
    }).toList();

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.04,
        vertical: MediaQuery.of(context).size.height * 0.01,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Office Services",
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.045,
              color: AppColors.putih,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: MediaQuery.of(context).size.width < 360 ? 3 : 4,
            crossAxisSpacing: 12,
            mainAxisSpacing: 24,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: accessibleItems.map((item) {
              return GestureDetector(
                onTap: item.onTap,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: iconSize * 1.8,
                      width: iconSize * 1.8,
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(item.icon,
                          size: iconSize, color: AppColors.putih),
                    ),
                    const SizedBox(height: 6),
                    Flexible(
                      child: Text(
                        item.label,
                        style: TextStyle(
                          fontSize: fontSize,
                          color: AppColors.putih,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
