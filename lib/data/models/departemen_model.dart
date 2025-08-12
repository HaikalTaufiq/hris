class Departemen {
  final int id;
  final String namaDepartemen;

  Departemen({
    required this.id,
    required this.namaDepartemen,
  });

  factory Departemen.fromJson(Map<String, dynamic> json) {
    return Departemen(
      id: json['id'],
      namaDepartemen: json['nama_departemen'],
    );
  }
}
