import 'package:flutter/material.dart';
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
      children: const [
        DashboardHeader(),
        DashboardCard(),
        DashboardMenu(),
        AttendanceChart(),
        TechTaskChart(),
        StatusTaskChart(),
      ],
    );
  }
}
