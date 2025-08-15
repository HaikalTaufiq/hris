import 'package:flutter/material.dart';
import 'package:hr/core/theme.dart';
import 'package:hr/data/models/cuti_model.dart';
import 'package:intl/intl.dart';

class CutiCardProvider with ChangeNotifier {
  final CutiModel cuti;

  CutiCardProvider(this.cuti);

  bool get isPending => cuti.status.toLowerCase() == 'pending';

  Color get statusColor {
    switch (cuti.status.toLowerCase()) {
      case 'disetujui':
        return AppColors.green;
      case 'ditolak':
        return AppColors.red;
      default:
        return AppColors.yellow;
    }
  }

  String formatDate(String date) {
    if (date.isEmpty) return '-';
    return DateFormat('dd/MM/yyyy').format(DateTime.parse(date));
  }

  String get shortAlasan => cuti.alasan.length > 15
      ? '${cuti.alasan.substring(0, 15)}...'
      : cuti.alasan;

  Future<void> approve(Future<void> Function() onApprove) async {
    await onApprove();
  }

  Future<void> decline(Future<void> Function() onDecline) async {
    await onDecline();
  }

  void delete(VoidCallback onDelete) => onDelete();
}
