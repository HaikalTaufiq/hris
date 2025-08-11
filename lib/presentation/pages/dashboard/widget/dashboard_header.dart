import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr/core/theme.dart';
import 'package:hr/presentation/layouts/main_layout.dart';

class DashboardHeader extends StatefulWidget {
  const DashboardHeader({super.key});

  @override
  State<DashboardHeader> createState() => _DashboardHeaderState();
}

class _DashboardHeaderState extends State<DashboardHeader>
    with SingleTickerProviderStateMixin {
  bool _showDropdown = false;
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;
  late Animation<double> _fadeAnimation;

  final GlobalKey _menuKey = GlobalKey();

  OverlayEntry? _dropdownOverlay;

  void _toggleDropdown() {
    if (_showDropdown) {
      _hideDropdown();
    } else {
      _showDropdownMenu();
    }
  }

  void _showDropdownMenu() {
    RenderBox renderBox =
        _menuKey.currentContext!.findRenderObject() as RenderBox;
    Offset offset = renderBox.localToGlobal(Offset.zero);

    _dropdownOverlay = OverlayEntry(
      builder: (context) => Stack(
        children: [
          // Klik di luar = tutup dropdown
          GestureDetector(
            onTap: _hideDropdown,
            behavior: HitTestBehavior.translucent,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.transparent,
            ),
          ),

          // Dropdown
          Positioned(
            top: offset.dy,
            right: MediaQuery.of(context).size.width * 0.04,
            child: Material(
              color: Colors.transparent,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SizeTransition(
                  sizeFactor: _sizeAnimation,
                  axisAlignment: -1.0, // buka ke bawah
                  child: Container(
                    width: 200,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildDropdownItem("Dashboard", Icons.dashboard, () {
                          _hideDropdown();
                        }),
                        _buildDropdownItem("Profile", Icons.person, () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MainLayout(externalPageIndex: 8),
                            ),
                          );
                          _hideDropdown();
                        }),
                        _buildDropdownItem("Settings", Icons.settings, () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MainLayout(externalPageIndex: 7),
                            ),
                          );
                          _hideDropdown();
                        }),
                        _buildDropdownItem("Logout", Icons.logout, () {
                          _hideDropdown();
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_dropdownOverlay!);
    _controller.forward();
    setState(() {
      _showDropdown = true;
    });
  }

  void _hideDropdown() async {
    await _controller.reverse();
    _dropdownOverlay?.remove();
    _dropdownOverlay = null;
    setState(() {
      _showDropdown = false;
    });
  }

  Widget _buildDropdownItem(String text, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: AppColors.putih),
      title: Text(text,
          style: TextStyle(
              color: AppColors.putih,
              fontFamily: GoogleFonts.poppins().fontFamily)),
      onTap: onTap,
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    _sizeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.04,
          vertical: MediaQuery.of(context).size.height * 0.01,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MainLayout(externalPageIndex: 8),
                      ),
                    );
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: AppColors.putih),
                  ),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Elon Musk',
                        style: TextStyle(
                            fontSize: 24,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontWeight: FontWeight.bold,
                            color: AppColors.putih)),
                    Text('Super Admin',
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            height: 0.8,
                            fontWeight: FontWeight.w400,
                            color: AppColors.putih.withOpacity(0.5))),
                  ],
                ),
              ],
            ),
            GestureDetector(
              key: _menuKey,
              onTap: _toggleDropdown,
              child: FaIcon(FontAwesomeIcons.barsStaggered,
                  color: AppColors.putih, size: 25),
            ),
          ],
        ),
      ),
    );
  }
}
