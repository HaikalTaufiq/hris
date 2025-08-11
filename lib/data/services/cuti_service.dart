// ignore_for_file: avoid_print

import 'dart:convert';
// import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:hr/data/models/cuti_model.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CutiService {
  static const String baseUrl = 'http://192.168.20.50:8000/api/cuti';

  // Ambil token dari SharedPreferences
  static Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // Fetch cuti
  static Future<List<CutiModel>> fetchCuti() async {
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
      final List cutiList = jsonData['data'];
      return cutiList.map((json) => CutiModel.fromJson(json)).toList();
    } else {
      print('Gagal fetch cuti: ${response.statusCode} ${response.body}');
      throw Exception('Gagal memuat data cuti');
    }
  }
  
  static Future<bool> createCuti({
    required String nama,
    required String tipeCuti,
    required String tanggalMulai,
    required String tanggalSelesai,
    required String alasan,
  }) async {
    final token = await _getToken();
    if (token == null) throw Exception('Token tidak ditemukan. Harap login ulang.');

    try {
      // Asumsikan input tanggal format "dd / MM / yyyy" seperti yang kamu tampilkan di UI
      final formattedMulai = DateFormat('dd / MM / yyyy').parse(tanggalMulai).toIso8601String().split('T')[0];
      final formattedSelesai = DateFormat('dd / MM / yyyy').parse(tanggalSelesai).toIso8601String().split('T')[0];

      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'nama': nama,
          'tipe_cuti': tipeCuti,
          'tanggal_mulai': formattedMulai,
          'tanggal_selesai': formattedSelesai,
          'alasan': alasan,
        }),
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        print('Gagal mengajukan cuti: ${response.statusCode} ${response.body}');
        return false;
      }
    } catch (e) {
      print('❌ Format tanggal tidak valid: $tanggalMulai - $tanggalSelesai');
      return false;
    }
  }

  // Approve cuti
  static Future<String?> approveCuti(int id) async {
    final token = await _getToken();
    if (token == null) throw Exception('Token tidak ditemukan. Harap login ulang.');

    final response = await http.put(
      Uri.parse('$baseUrl/$id/approve'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['message'];
    } else {
      print('Gagal menyetujui cuti: ${response.statusCode} ${response.body}');
      return null;
    }
  }

  // Decline cuti
  static Future<String?> declineCuti(int id) async {
    final token = await _getToken();  
    if (token == null) throw Exception('Token tidak ditemukan. Harap login ulang.');

    final response = await http.put(
      Uri.parse('$baseUrl/$id/decline'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return json.decode(response.body)['message'];
    } else {
      print('Gagal menolak cuti: ${response.statusCode} ${response.body}');
      return null;
    }
  }
}