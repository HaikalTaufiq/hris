// ignore_for_file: non_constant_identifier_names

import 'dart:ui';

import 'package:hr/core/theme.dart';

class CutiModel {
  final int id;
  final int userId;
  final String tipe_cuti;
  final String tanggal_mulai;
  final String tanggal_selesai;
  final String alasan;
  late final String status;
  final Map<String, dynamic> user;

  CutiModel({
    required this.id,
    required this.userId,
    required this.tipe_cuti,
    required this.tanggal_mulai,
    required this.tanggal_selesai,
    required this.alasan,
    required this.status,
    required this.user,
  });

  factory CutiModel.fromJson(Map<String, dynamic> json) {
    return CutiModel(
      id: json['id'],
      userId: json['user_id'],
      tipe_cuti: json['tipe_cuti'],
      tanggal_mulai: json['tanggal_mulai'],
      tanggal_selesai: json['tanggal_selesai'],
      alasan: json['alasan'],
      status: json['status'],
      user: json['user'] ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'tipe_cuti': tipe_cuti,
      'tanggal_mulai': tanggal_mulai,
      'tanggal_selesai': tanggal_selesai,
      'alasan': alasan,
      'status': status,
      'user': user,
    };
  }

//Baca nama user
  String get nama =>
      (user['nama'] ?? user['name'] ?? user['full_name'] ?? '').toString();

  bool get isPending => status.toLowerCase() == 'pending';

//Motong alasan kepanjangan
  String get shortAlasan {
    const max = 15; // samain dengan kebutuhan UI kamu
    if (alasan.length <= max) return alasan;
    final head = alasan.substring(0, max);
    final cutAt = head.lastIndexOf(' ');
    return (cutAt > 0 ? head.substring(0, cutAt) : head) + '...';
  }

//kondisi warna status
  Color get statusColor {
    switch (status.toLowerCase()) {
      case 'disetujui':
        return AppColors.green;
      case 'ditolak':
        return AppColors.red;
      default:
        return AppColors.yellow;
    }
  }
}
