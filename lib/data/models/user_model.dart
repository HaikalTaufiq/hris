import 'package:hr/data/models/departemen_model.dart';
import 'package:hr/data/models/jabatan_model.dart';
import 'package:hr/data/models/peran_model.dart';
class UserModel {
  final int id;
  final String nama;
  final String email;
  final String jenisKelamin;
  final String statusPernikahan;
  final JabatanModel? jabatan; 
  final PeranModel peran;
  final DepartemenModel departemen;
  final String? gajiPokok;
  final String? npwp;
  final String? bpjsKesehatan;
  final String? bpjsKetenagakerjaan;


  UserModel({
    required this.id,
    required this.nama,
    required this.email,
    required this.jenisKelamin,
    required this.statusPernikahan,
    this.jabatan,
    required this.peran,
    required this.departemen,
    this.gajiPokok,
    this.npwp,
    this.bpjsKesehatan,
    this.bpjsKetenagakerjaan,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      nama: json['nama'] ?? '',
      email: json['email'] ?? '',
      gajiPokok: json['gaji_pokok'],
      npwp: json['npwp'],
      bpjsKesehatan: json['bpjs_kesehatan'],
      bpjsKetenagakerjaan: json['bpjs_ketenagakerjaan'],
      jenisKelamin: json['jenis_kelamin'] ?? '',
      statusPernikahan: json['status_pernikahan'] ?? '',
      jabatan: json['jabatan'] != null ? JabatanModel.fromJson(json['jabatan']) : null,
      peran: PeranModel.fromJson(json['peran']),
      departemen: DepartemenModel.fromJson(json['departemen']),
    );
  }
}
