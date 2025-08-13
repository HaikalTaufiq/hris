import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr/core/theme.dart';
import 'package:hr/data/models/cuti_model.dart';
import 'package:hr/presentation/pages/cuti/cuti_form/cuti_edit_form.dart';
import 'package:hr/provider/features/features_guard.dart';
import 'package:hr/provider/user_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CutiCard extends StatelessWidget {
  final CutiModel cuti;
  final Future<void> Function() onApprove;
  final Future<void> Function() onDecline;
  final VoidCallback onDelete;

  const CutiCard({
    super.key,
    required this.cuti,
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

  // ======================= BUILD =======================
  @override
  Widget build(BuildContext context) {
    final isPending = cuti.status.toLowerCase() == 'pending';

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
                  'Detail Cuti',
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
                    _buildDetailItem('Nama', cuti.user['nama']),
                    _buildDetailItem('Status', cuti.status,
                        color: getStatusColor(cuti.status)),
                    _buildDetailItem('Tipe Cuti', cuti.tipe_cuti),
                    _buildDetailItem(
                        'Tanggal Mulai', _formatDate(cuti.tanggal_mulai)),
                    _buildDetailItem(
                        'Tanggal Selesai', _formatDate(cuti.tanggal_selesai)),
                    _buildDetailItem('Alasan', cuti.alasan),
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
                    cuti.user['nama'],
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
                          color: getStatusColor(cuti.status),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        cuti.status,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          color: getStatusColor(cuti.status),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Tipe cuti
              Text(
                cuti.tipe_cuti,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  color: AppColors.putih,
                ),
              ),
              const SizedBox(height: 8),

              // Periode cuti
              Text(
                '${_formatDate(cuti.tanggal_mulai)} - ${_formatDate(cuti.tanggal_selesai)}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  color: AppColors.putih,
                ),
              ),
              const SizedBox(height: 8),

              // Alasan singkat
              Text(
                cuti.alasan.length > 15
                    ? '${cuti.alasan.substring(0, 15)}...'
                    : cuti.alasan,
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
                          featureId: 'user_delete_cuti',
                          child: _buildActionButton(
                              'Delete', AppColors.red, onDelete),
                        ),
                        FeatureGuard(
                          featureId: 'user_edit_cuti',
                          child:
                              _buildActionButton('Edit', AppColors.yellow, () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CutiEditForm(
                                  cuti: cuti, // kirim model tugas langsung
                                ),
                              ),
                            );
                          }),
                        ),
                        //Super Admin
                        Consumer<UserProvider>(
                            builder: (context, userProvider, _) {
                          return FeatureGuard(
                            featureId: 'decline_cuti',
                            child: _buildActionButton(
                                'Decline', AppColors.red, onDecline),
                          );
                        }),
                        FeatureGuard(
                          featureId: 'approve_cuti',
                          child: _buildActionButton(
                              'Approve', AppColors.green, onApprove),
                        ),
                      ]
                    : [
                        //User
                        FeatureGuard(
                          featureId: 'user_delete_cuti',
                          child: _buildActionButton(
                              'Delete', AppColors.red, onDelete),
                        ),
                        FeatureGuard(
                          featureId: 'user_edit_cuti',
                          child:
                              _buildActionButton('Edit', AppColors.yellow, () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CutiEditForm(
                                  cuti: cuti,
                                ),
                              ),
                            );
                          }),
                        ),
                        //Super Admin
                        FeatureGuard(
                          featureId: 'delete_cuti',
                          child: _buildActionButton(
                              'Delete', AppColors.red, onDelete),
                        ),
                        FeatureGuard(
                          featureId: 'edit_cuti',
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
                                  "Update Status Cuti",
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
                                        await onApprove();
                                        Navigator.pop(context);
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
                                        await onDecline();
                                        Navigator.pop(context);
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
                        ),
                      ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
