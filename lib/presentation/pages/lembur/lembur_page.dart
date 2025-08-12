// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hr/core/header.dart';
import 'package:hr/core/helpers/notification_helper.dart';
import 'package:hr/data/models/lembur_model.dart';
import 'package:hr/core/theme.dart';
import 'package:hr/presentation/pages/lembur/lembur_form/lembur_form.dart';
import 'package:hr/presentation/pages/lembur/widgets/lembur_card.dart';
import 'package:hr/presentation/pages/lembur/widgets/lembur_search.dart';
import 'package:hr/data/services/lembur_service.dart';

class LemburPage extends StatefulWidget {
  const LemburPage({super.key});

  @override
  State<LemburPage> createState() => _LemburPageState();
}

class _LemburPageState extends State<LemburPage> {
  late Future<List<LemburModel>> _lemburList;

  @override
  void initState() {
    super.initState();
    _lemburList = LemburService.fetchLembur();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FutureBuilder<List<LemburModel>>(
          future: _lemburList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('Belum ada data lembur.'));
            } else {
              final lemburData = snapshot.data!;
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: lemburData.length + 2,
                itemBuilder: (context, index) {
                  if (index == 0)
                    return const Header(title: 'Pengajuan Lembur');
                  if (index == 1) return const LemburSearch();
                  final lembur = lemburData[index - 2];
                  return LemburCard(
                    lembur: lembur,
                    onApprove: () async {
                      final message =
                          await LemburService.approveLembur(lembur.id);
                      if (message != null) {
                        setState(() {
                          _lemburList = LemburService.fetchLembur();
                        });
                        NotificationHelper.showSnackBar(context, message,
                            isSuccess: true);
                      } else {
                        NotificationHelper.showSnackBar(
                            context, 'Gagal menyetujui lembur',
                            isSuccess: false);
                      }
                    },
                    onDecline: () async {
                      final message =
                          await LemburService.declineLembur(lembur.id);
                      if (message != null) {
                        setState(() {
                          _lemburList = LemburService.fetchLembur();
                        });
                        NotificationHelper.showSnackBar(context, message,
                            isSuccess: true);
                      } else {
                        NotificationHelper.showSnackBar(
                            context, 'Gagal menolak lembur',
                            isSuccess: false);
                      }
                    },
                  );
                },
              );
            }
          },
        ),

        // FAB (Floating Button)
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const LemburForm()),
              );
            },
            backgroundColor: AppColors.bg,
            shape: const CircleBorder(),
            child: FaIcon(FontAwesomeIcons.plus, color: AppColors.putih),
          ),
        ),
      ],
    );
  }
}
