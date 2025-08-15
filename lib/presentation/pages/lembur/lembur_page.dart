import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr/components/custom/loading.dart';
import 'package:hr/components/search_bar/search_bar.dart';
import 'package:hr/components/custom/header.dart';
import 'package:hr/core/theme.dart';
import 'package:hr/presentation/pages/lembur/lembur_form/lembur_form.dart';
import 'package:hr/presentation/pages/lembur/widgets/lembur_card.dart';
import 'package:hr/provider/features/features_guard.dart';
import 'package:hr/provider/function/lembur_provider.dart';
import 'package:hr/provider/ui/lembur_card_provider.dart';
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

  Future<void> _refreshData() async {
    await context.read<LemburProvider>().fetchLembur();
  }

  @override
  Widget build(BuildContext context) {
    final lemburProvider = context.watch<LemburProvider>();
    return Stack(
      children: [
        RefreshIndicator(
          onRefresh: _refreshData,
          child: ListView(
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
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.hourglass_empty,
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
                  itemCount: lemburProvider.lemburList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final lembur = lemburProvider.lemburList[index];
                    return ChangeNotifierProvider(
                      create: (_) => LemburCardProvider(lembur),
                      child: Consumer<LemburCardProvider>(
                        builder: (context, cardProvider, _) {
                          return LemburCard(
                            lembur: lembur,
                            onApprove: cardProvider.getApproveCallback(context),
                            onDecline: cardProvider.getDeclineCallback(context),
                            onDelete: cardProvider.getDeleteCallback(context),
                          );
                        },
                      ),
                    );
                  },
                ),
            ],
          ),
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
