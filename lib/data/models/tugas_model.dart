// ignore_for_file: non_constant_identifier_names

class DepartemenModel {
  final String id;
  final String nama_departemen;

  DepartemenModel({
    required this.id,
    required this.nama_departemen,
  });

  factory DepartemenModel.fromJson(Map<String, dynamic> json) {
    return DepartemenModel(
      id: json['id'].toString(),
      nama_departemen: json['nama_departemen'] ?? '',
    );
  }
}

class UserModel {
  final String id;
  final String nama;   
  final DepartemenModel? departemen;

  UserModel({
    required this.id,
    required this.nama,
    this.departemen,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'].toString(),
      nama: json['nama'] ?? '',
      departemen: json['departemen'] != null
          ? DepartemenModel.fromJson(json['departemen'])
          : null,
    );
  }
}

class TugasModel {
  final String id;
  final String nama_tugas;
  final String jam_mulai;
  final String tanggal_mulai;
  final String tanggal_selesai;
  final String user_id;
  final String departemen_id;
  final String lokasi;
  final String note;
  final String status;
  final UserModel? user;

  TugasModel({
    required this.id,
    required this.nama_tugas,
    required this.jam_mulai,
    required this.tanggal_mulai,
    required this.tanggal_selesai,
    required this.user_id,
    required this.departemen_id,
    required this.lokasi,
    required this.note,
    required this.status,
    this.user,
  });

  factory TugasModel.fromJson(Map<String, dynamic> json) {
    return TugasModel(
      id: json['id'].toString(),
      nama_tugas: json['nama_tugas'] ?? '',
      jam_mulai: json['jam_mulai'] ?? '',
      tanggal_mulai: json['tanggal_mulai'] ?? '',
      tanggal_selesai: json['tanggal_selesai'] ?? '',
      user_id: json['user_id'].toString(),
      departemen_id: json['departemen_id'].toString(),
      lokasi: json['lokasi'] ?? '',
      note: json['note'] ?? '',
      status: json['status'] ?? '',
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
    );
  }
}
