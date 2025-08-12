import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hr/core/theme.dart';

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

  String _nama = "";
  String _peran = "";

  final GlobalKey _menuKey = GlobalKey();
  OverlayEntry? _dropdownOverlay;

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

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _nama = prefs.getString('nama') ?? '';
      _peran = prefs.getString('peran') ?? '';
    });
  }

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
          GestureDetector(
            onTap: _hideDropdown,
            behavior: HitTestBehavior.translucent,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.transparent,
            ),
          ),
          Positioned(
            top: offset.dy,
            right: MediaQuery.of(context).size.width * 0.04,
            child: Material(
              color: Colors.transparent,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SizeTransition(
                  sizeFactor: _sizeAnimation,
                  axisAlignment: -1.0,
                  child: Container(
                    width: 200,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: hitam,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildDropdownItem("Dashboard", Icons.dashboard, _hideDropdown),
                        _buildDropdownItem("Profile", Icons.person, _hideDropdown),
                        _buildDropdownItem("Settings", Icons.settings, _hideDropdown),
                        _buildDropdownItem("Logout", Icons.logout, _hideDropdown),
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
      leading: Icon(icon, color: Colors.white),
      title: Text(text,
          style: TextStyle(
              color: Colors.white,
              fontFamily: GoogleFonts.poppins().fontFamily)),
      onTap: onTap,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.04,
        vertical: MediaQuery.of(context).size.height * 0.01,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(shape: BoxShape.circle, color: putih),
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_nama,
                      style: TextStyle(
                          fontSize: 24,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontWeight: FontWeight.bold,
                          color: putih)),
                  Text(_peran,
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          height: 0.8,
                          fontWeight: FontWeight.w400,
                          color: const Color.fromARGB(172, 224, 224, 224))),
                ],
              ),
            ],
          ),
          GestureDetector(
            key: _menuKey,
            onTap: _toggleDropdown,
            child: FaIcon(FontAwesomeIcons.barsStaggered, color: putih, size: 25),
          ),
        ],
      ),
    );
  }
}
