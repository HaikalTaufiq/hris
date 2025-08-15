import 'package:flutter/material.dart';
import 'package:hr/components/custom/show_confirmation.dart';
import 'package:hr/core/helpers/notification_helper.dart';
import 'package:hr/core/theme.dart';
import 'package:hr/data/models/lembur_model.dart';
import 'package:hr/provider/function/lembur_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class LemburCardProvider with ChangeNotifier {
  final LemburModel lembur;

  LemburCardProvider(this.lembur);

  bool get isPending => lembur.status.toLowerCase() == 'pending';

  Color get statusColor {
    switch (lembur.status.toLowerCase()) {
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

  String formatTime(String time) {
    if (time.isEmpty) return '-';
    try {
      return DateFormat('HH:mm').format(DateFormat('HH:mm:ss').parse(time));
    } catch (_) {
      return time;
    }
  }

  String get shortDeskripsi => lembur.deskripsi.length > 20
      ? '${lembur.deskripsi.substring(0, 20)}...'
      : lembur.deskripsi;

  // Internal methods that handle the actual logic
  Future<void> _approve(BuildContext context) async {
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

      // Refresh the main list after successful action
      if (message != null) {
        context.read<LemburProvider>().fetchLembur();
      }
    }
  }

  Future<void> _decline(BuildContext context) async {
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

      // Refresh the main list after successful action
      if (message != null) {
        context.read<LemburProvider>().fetchLembur();
      }
    }
  }

  Future<void> _delete(BuildContext context) async {
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

      // Refresh the main list after successful action
      if (message != null) {
        context.read<LemburProvider>().fetchLembur();
      }
    }
  }

  // Public methods that return the appropriate callbacks for LemburCard
  Future<void> Function() getApproveCallback(BuildContext context) {
    return () => _approve(context);
  }

  Future<void> Function() getDeclineCallback(BuildContext context) {
    return () => _decline(context);
  }

  VoidCallback getDeleteCallback(BuildContext context) {
    return () => _delete(context);
  }
}
