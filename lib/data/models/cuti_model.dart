// ignore_for_file: non_constant_identifier_names

class CutiModel {
  final int id;
  final int userId;
  final String tipe_cuti;
  final String tanggal_mulai;
  final String tanggal_selesai;
  final String alasan;
  final String status;
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
      user: json['user'],
    );
  }
}
