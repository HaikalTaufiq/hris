import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr/components/custom/loading.dart';
import 'package:hr/components/custom/show_confirmation.dart';
import 'package:hr/components/search_bar/search_bar.dart';
import 'package:hr/components/custom/header.dart';
import 'package:hr/core/helpers/notification_helper.dart';
import 'package:hr/data/models/lembur_model.dart';
import 'package:hr/core/theme.dart';
import 'package:hr/presentation/pages/lembur/lembur_form/lembur_form.dart';
import 'package:hr/presentation/pages/lembur/widgets/lembur_card.dart';
import 'package:hr/provider/features/features_guard.dart';
import 'package:hr/provider/lembur_provider.dart';
import 'package:provider/provider.dart';

class LemburPage extends StatefulWidget {
  const LemburPage({super.key});

  @override
  State<LemburPage> createState() => _LemburPageState();
}

class _LemburPageState extends State<LemburPage> {
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<LemburProvider>().fetchLembur();
    });
  }

  Future<void> _approveLembur(LemburModel lembur) async {
    final confirmed = await showConfirmationDialog(
      context,
      title: "Konfirmasi Persetujuan",
      content: "Apakah Anda yakin ingin menyetujui lembur ini?",
      confirmText: "Setuju",
      cancelText: "Batal",
      confirmColor: AppColors.green,
    );

    if (confirmed) {
      final message =
          await context.read<LemburProvider>().approveLembur(lembur.id);
      NotificationHelper.showSnackBar(
        context,
        message ?? 'Gagal menyetujui lembur',
        isSuccess: message != null,
      );
    }
  }

  Future<void> _declineLembur(LemburModel lembur) async {
    final confirmed = await showConfirmationDialog(
      context,
      title: "Konfirmasi Penolakan",
      content: "Apakah Anda yakin ingin menolak lembur ini?",
      confirmText: "Tolak",
      cancelText: "Batal",
      confirmColor: AppColors.red,
    );

    if (confirmed) {
      final message =
          await context.read<LemburProvider>().declineLembur(lembur.id);
      NotificationHelper.showSnackBar(
        context,
        message ?? 'Gagal menolak lembur',
        isSuccess: message != null,
      );
    }
  }

  Future<void> _deleteLembur(LemburModel lembur) async {
    final confirmed = await showConfirmationDialog(
      context,
      title: "Konfirmasi Hapus",
      content: "Apakah Anda yakin ingin menghapus lembur ini?",
      confirmText: "Hapus",
      cancelText: "Batal",
      confirmColor: AppColors.red,
    );

    if (confirmed) {
      final message =
          await context.read<LemburProvider>().deleteLembur(lembur.id);
      NotificationHelper.showSnackBar(
        context,
        message ?? 'Gagal menghapus lembur',
        isSuccess: message != null,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final lemburProvider = context.watch<LemburProvider>();

    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Header(title: 'Pengajuan Lembur'),
            SearchingBar(
              controller: searchController,
              onChanged: (value) {},
              onFilter1Tap: () {},
              onFilter2Tap: () {},
            ),
            if (lemburProvider.isLoading)
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: const Center(child: LoadingWidget()),
              )
            else if (lemburProvider.errorMessage != null)
              Center(child: Text('Error: ${lemburProvider.errorMessage}'))
            else if (lemburProvider.lemburList.isEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    'Belum ada data lembur.',
                    style: TextStyle(
                      color: AppColors.putih,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                    ),
                  ),
                ),
              )
            else
              ListView.builder(
                itemCount: lemburProvider.lemburList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final lembur = lemburProvider.lemburList[index];
                  return LemburCard(
                    lembur: lembur,
                    onApprove: () => _approveLembur(lembur),
                    onDecline: () => _declineLembur(lembur),
                    onDelete: () => _deleteLembur(lembur),
                  );
                },
              ),
          ],
        ),
        FeatureGuard(
          featureId: "add_lembur",
          child: Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: () async {
                final result = await Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const LemburForm()),
                );

                if (result == true) {
                  context.read<LemburProvider>().fetchLembur();
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
