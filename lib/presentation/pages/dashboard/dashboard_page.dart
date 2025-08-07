import 'package:flutter/material.dart';
import 'package:hr/presentation/pages/dashboard/widget/dashboard_card.dart';
import 'package:hr/presentation/pages/dashboard/widget/attendance_chart.dart';
import 'package:hr/presentation/pages/dashboard/widget/dashboard_header.dart';
import 'package:hr/presentation/pages/dashboard/widget/dashboard_menu.dart';
import 'package:hr/presentation/pages/dashboard/widget/status_task_chart.dart';
import 'package:hr/presentation/pages/dashboard/widget/tech_task_chart.dart';

class DashboardPage extends StatefulWidget {
  final String nama;
  final String peran;

  const DashboardPage({
    super.key,
    required this.nama,
    required this.peran,
  });

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}


class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        DashboardHeader(nama: widget.nama, peran: widget.peran),
        const DashboardCard(),
        const DashboardMenu(),
        const AttendanceChart(),
        const TechTaskChart(),
        const StatusTaskChart(),
      ],
    );
  }
}
