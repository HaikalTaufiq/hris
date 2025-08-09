import 'package:flutter/material.dart';
import 'package:hr/core/header.dart';
import 'package:hr/presentation/dashboard_menu/log_aktivitas/widgets/log_search.dart';
import 'package:hr/presentation/dashboard_menu/log_aktivitas/widgets/log_tabel.dart';

class LogPage extends StatefulWidget {
  const LogPage({super.key});

  @override
  State<LogPage> createState() => _LogPageState();
}

class _LogPageState extends State<LogPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        Header(title: 'Log Aktivitas'),
        LogSearch(),
        LogTabel(),
        LogTabel(),
        LogTabel(),
      ],
    );
  }
}
