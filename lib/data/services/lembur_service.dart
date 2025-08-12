// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:hr/data/models/lembur_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LemburService {
  static const String baseUrl = 'http://192.168.20.50:8000/api/lembur';

  // Ambil token dari SharedPreferences
  static Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // Fetch lembur
  static Future<List<LemburModel>> fetchLembur() async {
    final token = await _getToken();
    if (token == null) throw Exception('Token tidak ditemukan. Harap login ulang.');

    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List lemburList = jsonData['data'];
      return lemburList.map((json) => LemburModel.fromJson(json)).toList();
    } else {
      print('Gagal fetch lembur: ${response.statusCode} ${response.body}');
      throw Exception('Gagal memuat data lembur');
    }
  }

  // Fungsi mengajukan lembur
  static Future<bool> createLembur({
    required String tanggal,
    required String jamMulai,
    required String jamSelesai,
    required String deskripsi,
  }) async {
    final token = await _getToken();
    if (token == null) throw Exception('Token tidak ditemukan. Harap login ulang.');

    try {
      tanggal = DateFormat('dd / MM / yyyy').parse(tanggal).toIso8601String().split('T')[0];
    } catch (e) {
      print('❌ Format tanggal tidak valid: $tanggal');
      return false;
    }

    if (!RegExp(r'^\d{2}:\d{2}$').hasMatch(jamMulai) || !RegExp(r'^\d{2}:\d{2}$').hasMatch(jamSelesai)) {
      print('❌ Format jam tidak valid: $jamMulai - $jamSelesai');
      return false;
    }

    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'tanggal': tanggal,
        'jam_mulai': jamMulai,
        'jam_selesai': jamSelesai,
        'deskripsi': deskripsi,
      }),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      print('❌ Gagal create lembur: ${response.statusCode} ${response.body}');
      return false;
    }
  }

  // Fungsi menyetuji lembur
  static Future<String?> approveLembur(int id) async {
    final token = await _getToken();
    if (token == null) return 'Token tidak ditemukan. Harap login ulang.';

    final response = await http.put(
      Uri.parse('$baseUrl/$id/approve'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return jsonResponse['message'];
    } else {
      print('❌ Gagal menyetujui lembur: ${response.statusCode} ${response.body}');
      return null;
    }
  }

  // Fungsi menolak lembur
  static Future<String?> declineLembur(int id) async {
    final token = await _getToken();
    if (token == null) return 'Token tidak ditemukan. Harap login ulang.';

    final response = await http.put(
      Uri.parse('$baseUrl/$id/decline'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return jsonResponse['message'];
    } else {
      print('❌ Gagal menolak lembur: ${response.statusCode} ${response.body}');
      return null;
    }
  }

}
