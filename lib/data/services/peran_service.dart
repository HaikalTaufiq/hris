import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class PeranService {
  static const String baseUrl = 'http://192.168.20.50:8000';

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<List<String>> fetchPeran() async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/peran'),
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List dataList = jsonData['data'];

      return dataList.map((json) => json['nama_peran'] as String).toList();
    } else {
      throw Exception('Gagal memuat data peran: ${response.statusCode}');
    }
  }

}