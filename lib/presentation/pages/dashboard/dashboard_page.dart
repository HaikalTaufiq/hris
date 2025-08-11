import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hr/data/model/dahsboard_menu_item.dart';
import 'package:hr/presentation/layouts/main_layout.dart';
import 'package:hr/presentation/pages/dashboard/widget/dashboard_card.dart';
import 'package:hr/presentation/pages/dashboard/widget/attendance_chart.dart';
import 'package:hr/presentation/pages/dashboard/widget/dashboard_header.dart';
import 'package:hr/presentation/pages/dashboard/widget/dashboard_menu.dart';
import 'package:hr/presentation/pages/dashboard/widget/status_task_chart.dart';
import 'package:hr/presentation/pages/dashboard/widget/tech_task_chart.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const DashboardHeader(),
        const DashboardCard(),
        DashboardMenu(
          items: [
            DashboardMenuItem(
              label: "Karyawan",
              icon: FontAwesomeIcons.userGroup,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        MainLayout(externalPageIndex: 0), // KaryawanPage
                  ),
                );
              },
            ),
            DashboardMenuItem(
              label: "Gaji",
              icon: FontAwesomeIcons.moneyBill,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MainLayout(externalPageIndex: 1),
                  ),
                );
              },
            ),
            DashboardMenuItem(
              label: "Departemen",
              icon: FontAwesomeIcons.landmark,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MainLayout(externalPageIndex: 2),
                  ),
                );
              },
            ),
            DashboardMenuItem(
              label: "Jabatan",
              icon: FontAwesomeIcons.sitemap,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MainLayout(externalPageIndex: 3),
                  ),
                );
              },
            ),
            DashboardMenuItem(
              label: "Hak Akses",
              icon: FontAwesomeIcons.fileShield,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MainLayout(externalPageIndex: 4),
                  ),
                );
              },
            ),
            DashboardMenuItem(
              label: "Tentang",
              icon: FontAwesomeIcons.infoCircle,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MainLayout(externalPageIndex: 5),
                  ),
                );
              },
            ),
            DashboardMenuItem(
              label: "Log Aktivitas",
              icon: FontAwesomeIcons.history,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MainLayout(externalPageIndex: 6),
                  ),
                );
              },
            ),
            DashboardMenuItem(
              label: "Pengaturan",
              icon: FontAwesomeIcons.gear,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MainLayout(externalPageIndex: 7),
                  ),
                );
              },
            ),
          ],
        ),
        const AttendanceChart(),
        const TechTaskChart(),
        const StatusTaskChart(),
      ],
    );
  }
}
