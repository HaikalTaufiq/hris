// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hr/data/models/tugas_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TugasService {
  static const String baseUrl = 'http://192.168.20.50:8000';

  //Ambil token dari SharedPreferences
  static Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // Fetch tugas
  static Future<List<TugasModel>> fetchTugas() async {
    final token = await _getToken();
    if (token == null) throw Exception('Token tidak ditemukan. Harap login ulang.');

    final response = await http.get(
      Uri.parse('$baseUrl/api/tugas'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List tugasList = jsonData['data'];
      return tugasList.map((json) => TugasModel.fromJson(json)).toList();
    } else {
      print('Gagal fetch tugas: ${response.statusCode} ${response.body}');
      throw Exception('Gagal memuat data tugas');
    }
  }

  // lib/data/services/tugas_service.dart
  static Future<Map<String, dynamic>> deleteTugas(int id) async {
    final token = await _getToken();
    if (token == null) throw Exception('Token tidak ditemukan. Harap login ulang.');

    final response = await http.delete(
      Uri.parse('$baseUrl/api/tugas/$id'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    final body = json.decode(response.body);

    return {
      'success': response.statusCode == 200,
      'message': body['message'] ??
          (response.statusCode == 200
              ? 'Tugas berhasil dihapus'
              : 'Gagal menghapus tugas'),
    };
  }
}