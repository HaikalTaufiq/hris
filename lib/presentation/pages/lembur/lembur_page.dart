import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr/components/custom/loading.dart';
import 'package:hr/components/search_bar/search_bar.dart';
import 'package:hr/components/custom/header.dart';
import 'package:hr/core/helpers/notification_helper.dart';
import 'package:hr/data/models/lembur_model.dart';
import 'package:hr/core/theme.dart';
import 'package:hr/presentation/pages/lembur/lembur_form/lembur_form.dart';
import 'package:hr/presentation/pages/lembur/widgets/lembur_card.dart';
import 'package:hr/data/services/lembur_service.dart';

class LemburPage extends StatefulWidget {
  const LemburPage({super.key});

  @override
  State<LemburPage> createState() => _LemburPageState();
}

class _LemburPageState extends State<LemburPage> {
  late Future<List<LemburModel>> _lemburList;
  final searchController = TextEditingController(); // value awal

  @override
  void initState() {
    super.initState();
    _lemburList = LemburService.fetchLembur();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Header(title: 'Pengajuan Lembur'),
            SearchingBar(
              controller: searchController,
              onChanged: (value) {
                print("Search Halaman A: $value");
              },
              onFilter1Tap: () => print("Filter1 Halaman A"),
              onFilter2Tap: () => print("Filter2 Halaman A"),
            ),
            FutureBuilder<List<LemburModel>>(
              future: _lemburList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: const Center(
                      child: LoadingWidget(),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: Text(
                      'Belum ada data lembur.',
                      style: TextStyle(
                        color: AppColors.putih,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                      ),
                    )),
                  );
                } else {
                  final lemburData = snapshot.data!;
                  return ListView.builder(
                    itemCount: lemburData.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final lembur = lemburData[index];
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
          ],
        ),

        // FAB (Floating Button)
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            onPressed: () async {
              final result = await Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const LemburForm()),
              );

              if (result == true) {
                setState(() {
                  _lemburList = LemburService.fetchLembur(); // refresh data
                });
              }
            },
            backgroundColor: AppColors.secondary,
            shape: const CircleBorder(),
            child: FaIcon(FontAwesomeIcons.plus, color: AppColors.putih),
          ),
        ),
      ],
    );
  }
}
