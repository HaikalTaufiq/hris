import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr/core/header.dart';
import 'package:hr/core/theme.dart';

class PengaturanPage extends StatefulWidget {
  const PengaturanPage({super.key});

  @override
  State<PengaturanPage> createState() => _PengaturanPageState();
}

class _PengaturanPageState extends State<PengaturanPage> {
  // List menu pengaturan
  final List<Map<String, dynamic>> menuItems = [
    {"title": "Profil", "icon": FontAwesomeIcons.user},
    {"title": "Notifikasi", "icon": FontAwesomeIcons.bell},
    {"title": "Privasi", "icon": FontAwesomeIcons.lock},
    {"title": "Tentang", "icon": FontAwesomeIcons.infoCircle},
    {"title": "Profil", "icon": FontAwesomeIcons.user},
    {"title": "Notifikasi", "icon": FontAwesomeIcons.bell},
    {"title": "Privasi", "icon": FontAwesomeIcons.lock},
    {"title": "Tentang", "icon": FontAwesomeIcons.infoCircle},
    {"title": "Tentang", "icon": FontAwesomeIcons.infoCircle},
    {"title": "Tentang", "icon": FontAwesomeIcons.infoCircle},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Header(title: "Pengaturan"),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.04,
            vertical: MediaQuery.of(context).size.height * 0.02,
          ),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: menuItems.length,
            separatorBuilder: (context, index) => const Divider(
              color: Colors.white,
              thickness: 0.5,
            ),
            itemBuilder: (context, index) {
              final item = menuItems[index];
              return _buildMenuItem(
                title: item["title"],
                icon: item["icon"],
                onTap: () {
                  debugPrint("${item["title"]} diklik");
                },
              );
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.04,
          ),
          child: SizedBox(
            child: ElevatedButton(
              onPressed: () {
                // TODO: handle submit
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primary,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Log Out',
                style: GoogleFonts.poppins(
                  color: putih,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            FaIcon(icon, size: 16, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
