// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr/components/custom/loading.dart';
import 'package:hr/components/custom/show_confirmation.dart';
import 'package:hr/components/search_bar/search_bar.dart';
import 'package:hr/components/custom/header.dart';
import 'package:hr/core/helpers/notification_helper.dart';
import 'package:hr/data/models/cuti_model.dart';
import 'package:hr/data/services/cuti_service.dart';
import 'package:hr/core/theme.dart';
import 'package:hr/presentation/pages/cuti/cuti_form/cuti_form.dart';
import 'package:hr/presentation/pages/cuti/widgets/cuti_card.dart';
import 'package:hr/provider/features/features_guard.dart';

class CutiPage extends StatefulWidget {
  const CutiPage({super.key});

  @override
  State<CutiPage> createState() => _CutiPageState();
}

class _CutiPageState extends State<CutiPage> {
  late Future<List<CutiModel>> _cutiList;
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _cutiList = CutiService.fetchCuti();
  }

  Future<void> _deleteCuti(CutiModel cuti) async {
    final confirmed = await showConfirmationDialog(
      context,
      title: "Konfirmasi Hapus",
      content: "Apakah Anda yakin ingin menghapus cuti ini?",
      confirmText: "Hapus",
      cancelText: "Batal",
      confirmColor: AppColors.red,
    );

    if (confirmed) {
      final result = await CutiService.deleteCuti(cuti.id);
      final message = result['message'] ?? 'Gagal menghapus cuti';
      final isSuccess = message.toLowerCase().contains('berhasil');

      NotificationHelper.showSnackBar(context, message, isSuccess: isSuccess);

      if (isSuccess) {
        setState(() {
          _cutiList = CutiService.fetchCuti();
        });
      }
    }
  }

  Future<void> _approveCuti(CutiModel cuti) async {
    final confirmed = await showConfirmationDialog(
      context,
      title: "Konfirmasi Persetujuan",
      content: "Apakah Anda yakin ingin menyetujui cuti ini?",
      confirmText: "Setuju",
      cancelText: "Batal",
      confirmColor: AppColors.green,
    );

    if (confirmed) {
      final message = await CutiService.approveCuti(cuti.id);
      if (message != null) {
        setState(() {
          _cutiList = CutiService.fetchCuti();
        });
        NotificationHelper.showSnackBar(context, message, isSuccess: true);
      } else {
        NotificationHelper.showSnackBar(
          context,
          'Gagal menyetujui cuti',
          isSuccess: false,
        );
      }
    }
  }

  Future<void> _declineCuti(CutiModel cuti) async {
    final confirmed = await showConfirmationDialog(
      context,
      title: "Konfirmasi Penolakan",
      content: "Apakah Anda yakin ingin menolak cuti ini?",
      confirmText: "Tolak",
      cancelText: "Batal",
      confirmColor: AppColors.red,
    );

    if (confirmed) {
      final message = await CutiService.declineCuti(cuti.id);
      if (message != null) {
        setState(() {
          _cutiList = CutiService.fetchCuti();
        });
        NotificationHelper.showSnackBar(context, message, isSuccess: true);
      } else {
        NotificationHelper.showSnackBar(
          context,
          'Gagal menolak cuti',
          isSuccess: false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Header(title: 'Pengajuan Cuti'),
            SearchingBar(
              controller: searchController,
              onChanged: (value) => print("Search: $value"),
              onFilter1Tap: () => print("Filter1"),
              onFilter2Tap: () => print("Filter2"),
            ),
            FutureBuilder<List<CutiModel>>(
              future: _cutiList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: const Center(child: LoadingWidget()),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Center(
                      child: Text(
                        'Tidak ada data cuti',
                        style: TextStyle(
                          color: AppColors.putih,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                        ),
                      ),
                    ),
                  );
                } else {
                  final cutiData = snapshot.data!;
                  return ListView.builder(
                    itemCount: cutiData.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final cuti = cutiData[index];
                      return CutiCard(
                        cuti: cuti,
                        onApprove: () => _approveCuti(cuti),
                        onDecline: () => _declineCuti(cuti),
                        onDelete: () => _deleteCuti(cuti),
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
        FeatureGuard(
          featureId: "add_cuti",
          child: Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: () async {
                final result = await Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const CutiForm()),
                );

                if (result == true) {
                  setState(() {
                    _cutiList = CutiService.fetchCuti();
                  });
                }
              },
              backgroundColor: AppColors.secondary,
              shape: const CircleBorder(),
              child: FaIcon(FontAwesomeIcons.plus, color: AppColors.putih),
            ),
          ),
        ),
      ],
    );
  }
}
