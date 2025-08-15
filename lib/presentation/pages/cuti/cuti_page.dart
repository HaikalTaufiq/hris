// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr/components/custom/loading.dart';
import 'package:hr/components/custom/show_confirmation.dart';
import 'package:hr/components/search_bar/search_bar.dart';
import 'package:hr/components/custom/header.dart';
import 'package:hr/core/helpers/notification_helper.dart';
import 'package:hr/data/models/cuti_model.dart';
import 'package:hr/core/theme.dart';
import 'package:hr/presentation/pages/cuti/cuti_form/cuti_form.dart';
import 'package:hr/presentation/pages/cuti/widgets/cuti_card.dart';
import 'package:hr/provider/cuti_provider.dart';
import 'package:hr/provider/features/features_guard.dart';
import 'package:provider/provider.dart';

class CutiPage extends StatefulWidget {
  const CutiPage({super.key});

  @override
  State<CutiPage> createState() => _CutiPageState();
}

class _CutiPageState extends State<CutiPage> {
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<CutiProvider>().fetchCuti();
    });
  }

  Future<void> _refreshData() async {
    await context.read<CutiProvider>().fetchCuti();
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
      final message = await context.read<CutiProvider>().deleteCuti(cuti.id);
      NotificationHelper.showSnackBar(
        context,
        message,
        isSuccess: message != null,
      );
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
      final message = await context.read<CutiProvider>().approveCuti(cuti.id);
      NotificationHelper.showSnackBar(
        context,
        message ?? 'Gagal menyetujui Cuti',
        isSuccess: message != null,
      );
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
      final message = await context.read<CutiProvider>().declineCuti(cuti.id);
      NotificationHelper.showSnackBar(
        context,
        message ?? 'Gagal menolak Cuti',
        isSuccess: message != null,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cutiProvider = context.watch<CutiProvider>();

    return Stack(
      children: [
        RefreshIndicator(
          onRefresh: _refreshData,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Header(title: 'Pengajuan Cuti'),
              SearchingBar(
                controller: searchController,
                onChanged: (value) => print("Search: $value"),
                onFilter1Tap: () => print("Filter1"),
                onFilter2Tap: () => print("Filter2"),
              ),
              if (cutiProvider.isLoading)
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: const Center(child: LoadingWidget()),
                )
              else if (cutiProvider.cutiList.isEmpty)
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.note_alt_outlined,
                          size: 64,
                          color: AppColors.putih.withOpacity(0.5),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Belum ada pengajuan',
                          style: TextStyle(
                            color: AppColors.putih,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Tap tombol + untuk menambah pengajuan baru',
                          style: TextStyle(
                            color: AppColors.putih.withOpacity(0.7),
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                )
              else
                ListView.builder(
                  itemCount: cutiProvider.cutiList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final cuti = cutiProvider.cutiList[index];
                    return CutiCard(
                      cuti: cuti,
                      onApprove: () => _approveCuti(cuti),
                      onDecline: () => _declineCuti(cuti),
                      onDelete: () => _deleteCuti(cuti),
                    );
                  },
                ),
            ],
          ),
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
                  setState(() {});
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
