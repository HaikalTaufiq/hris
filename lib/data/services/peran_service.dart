import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PeranService {
  static const String baseUrl = 'http://192.168.20.50:8000';

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<List<Map<String, dynamic>>> fetchPeran() async {
    final token = await getToken();

    final response = await http.get(
      Uri.parse('$baseUrl/api/peran'),
      headers: {
        'Authorization': 'Bearer $token', // kalau API pakai auth
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List dataList = jsonData['data'];

      // Sekarang kembalikan id + nama_peran
      return dataList.map((json) {
        return {
          'id': json['id'],
          'nama_peran': json['nama_peran'],
        };
      }).toList();
    } else {
      throw Exception('Gagal memuat data peran: ${response.statusCode}');
    }
  }
}
