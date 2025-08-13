import 'dart:convert';
import 'package:hr/data/models/departemen_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DepartemenService {
  static const String baseUrl = 'http://192.168.20.50:8000';

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<List<DepartemenModel>> fetchDepartemen() async {
    final token = await getToken();
    if (token == null) throw Exception('Token tidak ditemukan. Harap login ulang.');

    final response = await http.get(
      Uri.parse('$baseUrl/api/departemen'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List dataList = jsonData['data'];

      return dataList.map((json) => DepartemenModel.fromJson(json)).toList();
    } else {
      throw Exception('Gagal memuat data departemen: ${response.statusCode}');
    }
  }
}
