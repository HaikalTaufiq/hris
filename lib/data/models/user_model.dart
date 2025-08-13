import 'package:hr/data/models/departemen_model.dart';
import 'package:hr/data/models/peran_model.dart';

class UserModel {
  final int id;
  final String nama;
  final String email;
  final String jenisKelamin;
  final String statusPernikahan;
  final PeranModel peran;
  final DepartemenModel departemen;

  UserModel({
    required this.id,
    required this.nama,
    required this.email,
    required this.jenisKelamin,
    required this.statusPernikahan,
    required this.peran,
    required this.departemen,

  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      nama: json['nama'] ?? '',
      email: json['email'] ?? '',
      jenisKelamin: json['jenis_kelamin'] ?? '',
      statusPernikahan:json ['status_pernikahan'] ?? '',
      peran: PeranModel.fromJson(json['peran']),
      departemen: DepartemenModel.fromJson(json['departemen']),
    );
  }
}