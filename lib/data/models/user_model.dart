class UserModel {
  final int id;
  final String nama;
  final String email;
  final String peran;

  UserModel({
    required this.id,
    required this.nama,
    required this.email,
    required this.peran,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      nama: json['nama'],
      email: json['email'],
      peran: json['nama_peran'],
    );
  }
}
