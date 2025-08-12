import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr/core/theme.dart';
import 'package:hr/data/models/lembur_model.dart';
import 'package:intl/intl.dart';

class LemburCard extends StatelessWidget {
  final LemburModel lembur;
  final VoidCallback onApprove;
  final VoidCallback onDecline;

  const LemburCard({
    super.key,
    required this.lembur,
    required this.onApprove,
    required this.onDecline,
  });

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

  @override
  Widget build(BuildContext context) {
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
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(56, 5, 5, 5),
              blurRadius: 5,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
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
                    _buildDetailItem(
                      'Tanggal',
                      lembur.tanggal.isNotEmpty
                          ? DateFormat('dd/MM/yyyy')
                              .format(DateTime.parse(lembur.tanggal))
                          : '-',
                    ),
                    _buildDetailItem(
                      'Jam',
                      '${lembur.jamMulai.isNotEmpty ? DateFormat('HH:mm').format(DateFormat('HH:mm:ss').parse(lembur.jamMulai)) : ''} - '
                          '${lembur.jamSelesai.isNotEmpty ? DateFormat('HH:mm').format(DateFormat('HH:mm:ss').parse(lembur.jamSelesai)) : ''}',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${lembur.user['nama']}',
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
                      SizedBox(width: 8),
                      Text(
                        '${lembur.status}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          color: getStatusColor(lembur.status),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                lembur.tanggal.isNotEmpty
                    ? DateFormat('dd/MM/yyyy')
                        .format(DateTime.parse(lembur.tanggal))
                    : '',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  color: AppColors.putih,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '${lembur.jamMulai.isNotEmpty ? DateFormat('HH:mm').format(DateFormat('HH:mm:ss').parse(lembur.jamMulai)) : ''} '
                '- '
                '${lembur.jamSelesai.isNotEmpty ? DateFormat('HH:mm').format(DateFormat('HH:mm:ss').parse(lembur.jamSelesai)) : ''}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  color: AppColors.putih,
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: [
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
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: onDecline,
                    child: Container(
                      margin: EdgeInsets.only(left: 8),
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.04,
                        vertical: MediaQuery.of(context).size.height * 0.01,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.red,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(66, 0, 0, 0),
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        'Decline',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: onApprove,
                    child: Container(
                      margin: EdgeInsets.only(left: 8),
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.02,
                        vertical: MediaQuery.of(context).size.height * 0.01,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.green,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(66, 0, 0, 0),
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        'Approve',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          color: Colors.white,
                        ),
                      ),
                    ),
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
