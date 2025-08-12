import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hr/components/search_bar/search_bar.dart';
import 'package:hr/core/header.dart';
import 'package:hr/core/helpers/notification_helper.dart';
import 'package:hr/data/models/cuti_model.dart';
import 'package:hr/data/services/cuti_service.dart';
import 'package:hr/core/theme.dart';
import 'package:hr/presentation/pages/cuti/cuti_form/cuti_form.dart';
import 'package:hr/presentation/pages/cuti/widgets/cuti_card.dart';

class CutiPage extends StatefulWidget {
  const CutiPage({super.key});

  @override
  State<CutiPage> createState() => _CutiPageState();
}

class _CutiPageState extends State<CutiPage> {
  late Future<List<CutiModel>> _cutiList;
  final searchController = TextEditingController(); // value awal

  @override
  void initState() {
    super.initState();
    _cutiList = CutiService.fetchCuti();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Header(title: 'Manajemen Cuti'),
            SearchingBar(
              controller: searchController,
              onChanged: (value) {
                print("Search Halaman A: $value");
              },
              onFilter1Tap: () => print("Filter1 Halaman A"),
              onFilter2Tap: () => print("Filter2 Halaman A"),
            ),
            FutureBuilder<List<CutiModel>>(
              future: _cutiList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Tidak ada data cuti'));
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
                        onApprove: () async {
                          final message =
                              await CutiService.approveCuti(cuti.id);
                          if (message != null) {
                            setState(() {
                              _cutiList = CutiService.fetchCuti();
                            });
                            NotificationHelper.showSnackBar(context, message,
                                isSuccess: true);
                          } else {
                            NotificationHelper.showSnackBar(
                                context, 'Gagal menyetujui cuti',
                                isSuccess: false);
                          }
                        },
                        onDecline: () async {
                          final message =
                              await CutiService.declineCuti(cuti.id);
                          if (message != null) {
                            setState(() {
                              _cutiList = CutiService.fetchCuti();
                            });
                            NotificationHelper.showSnackBar(context, message,
                                isSuccess: true);
                          } else {
                            NotificationHelper.showSnackBar(
                                context, 'Gagal menolak cuti',
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
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const CutiForm()),
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
