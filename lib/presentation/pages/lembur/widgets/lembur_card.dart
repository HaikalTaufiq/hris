import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr/core/theme.dart';
import 'package:hr/data/models/lembur_model.dart';
import 'package:hr/presentation/pages/lembur/lembur_form/lembur_form_edit.dart';
import 'package:hr/provider/features/features_guard.dart';
import 'package:hr/provider/user_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class LemburCard extends StatelessWidget {
  final LemburModel lembur;
  final Future<void> Function() onApprove;
  final Future<void> Function() onDecline;
  final VoidCallback onDelete;

  const LemburCard({
    super.key,
    required this.lembur,
    required this.onApprove,
    required this.onDecline,
    required this.onDelete,
  });

  // ======================= HELPERS =======================
  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'disetujui':
        return AppColors.green;
      case 'ditolak':
        return AppColors.red;
      case 'pending':
      default:
        return AppColors.yellow;
    }
  }

  Widget _buildDetailItem(String label, String value, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: RichText(
        text: TextSpan(
          text: '$label: ',
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.putih,
          ),
          children: [
            TextSpan(
              text: value,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: color ?? AppColors.putih,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(String label, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(left: 8),
        width: 80, // Fixed width for consistency
        height: 38, // Fixed height for consistency
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(66, 0, 0, 0),
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          // Center the text
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontFamily: GoogleFonts.poppins().fontFamily,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  String _formatDate(String date) {
    if (date.isEmpty) return '-';
    return DateFormat('dd/MM/yyyy').format(DateTime.parse(date));
  }

  String _formatTime(String time) {
    if (time.isEmpty) return '-';
    try {
      return DateFormat('HH:mm').format(DateFormat('HH:mm:ss').parse(time));
    } catch (e) {
      return time;
    }
  }

  // ======================= BUILD =======================
  @override
  Widget build(BuildContext context) {
    final isPending = lembur.status.toLowerCase() == 'pending';

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.02,
        vertical: MediaQuery.of(context).size.height * 0.01,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.04,
          vertical: MediaQuery.of(context).size.height * 0.02,
        ),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(56, 5, 5, 5),
              blurRadius: 5,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                backgroundColor: AppColors.primary,
                title: Text(
                  'Detail Lembur',
                  style: TextStyle(
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    color: AppColors.putih,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailItem('Nama', lembur.user['nama']),
                    _buildDetailItem('Status', lembur.status,
                        color: getStatusColor(lembur.status)),
                    _buildDetailItem('Tanggal', _formatDate(lembur.tanggal)),
                    _buildDetailItem(
                      'Jam Mulai',
                      _formatTime(lembur.jamMulai),
                    ),
                    _buildDetailItem(
                      'Jam Selesai',
                      _formatTime(lembur.jamSelesai),
                    ),
                    _buildDetailItem('Keterangan', lembur.deskripsi),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Tutup',
                      style: TextStyle(
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        color: AppColors.putih,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Nama & status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    lembur.user['nama'],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      color: AppColors.putih,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                          color: getStatusColor(lembur.status),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        lembur.status,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          color: getStatusColor(lembur.status),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Tanggal
              Text(
                _formatDate(lembur.tanggal),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  color: AppColors.putih,
                ),
              ),
              const SizedBox(height: 8),

              // Jam lembur
              Text(
                '${_formatTime(lembur.jamMulai)} - ${_formatTime(lembur.jamSelesai)}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  color: AppColors.putih,
                ),
              ),
              const SizedBox(height: 8),

              // Keterangan singkat
              Text(
                lembur.deskripsi.length > 15
                    ? '${lembur.deskripsi.substring(0, 15)}...'
                    : lembur.deskripsi,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  color: AppColors.putih,
                ),
              ),
              const SizedBox(height: 8),

              // Tombol aksi
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: isPending
                    ? [
                        //User
                        FeatureGuard(
                          featureId: 'user_delete_lembur',
                          child: _buildActionButton(
                              'Delete', AppColors.red, onDelete),
                        ),
                        FeatureGuard(
                          featureId: 'user_edit_lembur',
                          child:
                              _buildActionButton('Edit', AppColors.yellow, () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => LemburFormEdit(
                                  lembur: lembur, // kirim model tugas langsung
                                ),
                              ),
                            );
                          }),
                        ),
                        //Super Admin
                        Consumer<UserProvider>(
                            builder: (context, userProvider, _) {
                          return FeatureGuard(
                            featureId: 'decline_lembur',
                            child: _buildActionButton(
                                'Decline', AppColors.red, onDecline),
                          );
                        }),
                        FeatureGuard(
                          featureId: 'approve_lembur',
                          child: _buildActionButton(
                              'Approve', AppColors.green, onApprove),
                        ),
                      ]
                    : [
                        //User
                        FeatureGuard(
                          featureId: 'user_delete_lembur',
                          child: _buildActionButton(
                              'Delete', AppColors.red, onDelete),
                        ),
                        FeatureGuard(
                          featureId: 'user_edit_lembur',
                          child:
                              _buildActionButton('Edit', AppColors.yellow, () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => LemburFormEdit(
                                  lembur: lembur, // kirim model tugas langsung
                                ),
                              ),
                            );
                          }),
                        ),
                        //Super Admin
                        FeatureGuard(
                          featureId: 'delete_lembur',
                          child: _buildActionButton(
                              'Delete', AppColors.red, onDelete),
                        ),
                        FeatureGuard(
                          featureId: 'edit_lembur',
                          child:
                              _buildActionButton('Edit', AppColors.yellow, () {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                backgroundColor: AppColors.bg,
                                title: Text(
                                  "Update Status Lembur",
                                  style: TextStyle(
                                    color: AppColors.putih,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.green,
                                        minimumSize:
                                            const Size(double.infinity, 48),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        elevation: 2,
                                      ),
                                      onPressed: () async {
                                        Navigator.of(context).pop();
                                        await onApprove();
                                      },
                                      label: Text(
                                        "Approve",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: GoogleFonts.poppins()
                                                .fontFamily),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.red,
                                        minimumSize:
                                            const Size(double.infinity, 48),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        elevation: 2,
                                      ),
                                      onPressed: () async {
                                        Navigator.of(context).pop();
                                        await onDecline();
                                      },
                                      label: Text(
                                        "Decline",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: GoogleFonts.poppins()
                                                .fontFamily),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        )
                      ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
