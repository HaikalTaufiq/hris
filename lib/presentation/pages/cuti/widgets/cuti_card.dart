import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr/core/theme.dart';
import 'package:hr/data/models/cuti_model.dart';
import 'package:intl/intl.dart';

class CutiCard extends StatelessWidget {
  final CutiModel cuti;
  final VoidCallback onApprove;
  final VoidCallback onDecline;

  const CutiCard({
    super.key,
    required this.cuti,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${cuti.user['nama']}',
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
                    SizedBox(width: 8),
                    Text(
                      '${cuti.status}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        color: getStatusColor(cuti.status),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              '${cuti.tipe_cuti}',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontFamily: GoogleFonts.poppins().fontFamily,
                color: AppColors.putih,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '${cuti.tanggal_mulai.isNotEmpty ? DateFormat('dd/MM/yyyy').format(DateTime.parse(cuti.tanggal_mulai)) : ''} - '
              '${cuti.tanggal_selesai.isNotEmpty ? DateFormat('dd/MM/yyyy').format(DateTime.parse(cuti.tanggal_selesai)) : ''}',
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
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: AppColors.primary,
                        title: Text(
                          'Detail Alasan Cuti',
                          style: TextStyle(
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            color: AppColors.putih,
                          ),
                        ),
                        content: Text(
                          cuti.alasan,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: AppColors.putih,
                          ),
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
                  child: Text(
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
                    )),
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
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      'Approved',
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
    );
  }
}
