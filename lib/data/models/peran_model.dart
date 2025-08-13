class PeranModel {
  final int? id;
  final String namaPeran;

  PeranModel({
    required this.id,
    required this.namaPeran,
  });

  factory PeranModel.fromJson(Map<String, dynamic> json) {
    return PeranModel(
      id: json['id'],
      namaPeran: json['nama_peran'],
    );
  }
}