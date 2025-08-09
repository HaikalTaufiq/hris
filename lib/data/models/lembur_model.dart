class LemburModel {
  final int id;
  final int userId;
  final String tanggal;
  final String jamMulai;
  final String jamSelesai;
  final String deskripsi;
  final String status;
  final Map<String, dynamic> user; 

  LemburModel({
    required this.id,
    required this.userId,
    required this.tanggal,
    required this.jamMulai,
    required this.jamSelesai,
    required this.deskripsi,
    required this.status,
    required this.user,
  });

  factory LemburModel.fromJson(Map<String, dynamic> json) {
    return LemburModel(
      id: json['id'],
      userId: json['user_id'],
      tanggal: json['tanggal'],
      jamMulai: json['jam_mulai'],
      jamSelesai: json['jam_selesai'],
      deskripsi: json['deskripsi'],
      status: json['status'],
      user: json['user'],
    );
  }
}
