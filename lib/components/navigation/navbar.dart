import 'package:flutter/material.dart';
import 'package:hr/core/theme.dart';

class NavBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const NavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        // Remove top border by setting elevation to 0 and canvasColor to match background
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          elevation: 0,
          backgroundColor: hitam,
          selectedItemColor:
              Colors.blue, // Change to your desired selected icon color
          unselectedItemColor:
              Colors.grey, // Change to your desired unselected icon color
          type: BottomNavigationBarType.fixed,
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: widget.selectedIndex,
        onTap: widget.onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month), label: 'Absen'),
          BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Tugas'),
          BottomNavigationBarItem(
              icon: Icon(Icons.lock_clock_outlined), label: 'Lembur'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_view_day), label: 'Cuti'),
        ],
      ),
    );
  }
}
