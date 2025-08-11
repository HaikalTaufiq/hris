import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
          splashFactory: NoSplash.splashFactory,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            elevation: 0,
            backgroundColor: Color(0xFF040404),
            selectedItemColor: Color.fromARGB(255, 255, 255, 255),
            unselectedItemColor: Color.fromARGB(255, 255, 255, 255),
            type: BottomNavigationBarType.fixed,
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: widget.selectedIndex,
          onTap: widget.onItemTapped,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
              icon: widget.selectedIndex == 0
                  ? const FaIcon(FontAwesomeIcons.house)
                  : const FaIcon(FontAwesomeIcons.house),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: widget.selectedIndex == 1
                  ? const FaIcon(FontAwesomeIcons.solidCalendarCheck)
                  : const FaIcon(FontAwesomeIcons.calendarCheck),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: widget.selectedIndex == 2
                  ? const FaIcon(FontAwesomeIcons.listCheck)
                  : const FaIcon(FontAwesomeIcons.listCheck),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: widget.selectedIndex == 3
                  ? const FaIcon(FontAwesomeIcons.solidClock)
                  : const FaIcon(FontAwesomeIcons.clock),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: widget.selectedIndex == 4
                  ? const FaIcon(FontAwesomeIcons.solidCalendarMinus)
                  : const FaIcon(FontAwesomeIcons.calendarMinus),
              label: '',
            ),
          ],
        ));
  }
}
