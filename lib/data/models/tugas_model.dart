// ignore_for_file: non_constant_identifier_names

import 'package:hr/data/models/user_model.dart';

class TugasModel {
  final int id;
  final String namaTugas;
  final String jamMulai;
  final String tanggalMulai;
  final String tanggalSelesai;
  final String lokasi;
  final String note;
  final String status;
  final List<UserModel> users;

  TugasModel({
    required this.id,
    required this.namaTugas,
    required this.jamMulai,
    required this.tanggalMulai,
    required this.tanggalSelesai,
    required this.lokasi,
    required this.note,
    required this.status,
    required this.users,
  });

  factory TugasModel.fromJson(Map<String, dynamic> json) {
    return TugasModel(
      id: json['id'],
      namaTugas: json['nama_tugas'] ?? '',
      jamMulai: json['jam_mulai'] ?? '',
      tanggalMulai: json['tanggal_mulai'] ?? '',
      tanggalSelesai: json['tanggal_selesai'] ?? '',
      lokasi: json['lokasi'] ?? '',
      note: json['instruksi_tugas'] ?? '',
      status: json['status'] ?? '',
      users: (json['users'] as List<dynamic>?)
              ?.map((userJson) => UserModel.fromJson(userJson))
              .toList() 
              ?? [],
    );
  }
}
