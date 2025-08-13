// ignore_for_file: avoid_print, no_leading_underscores_for_local_identifiers

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hr/data/models/tugas_model.dart';
import 'package:intl/intl.dart';
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

  // Tambah tugas
  static Future<Map<String, dynamic>> createTugas({
    required String judul,
    required String jamMulai,
    required String tanggalMulai,
    required String tanggalSelesai,
    required String assignmentMode,
    int? person,
    int? departmentId,
    required String lokasi,
    required String note,
  }) async {
    final token = await _getToken();
    if (token == null) throw Exception('Token tidak ditemukan. Harap login ulang.');

    // Format tanggal untuk API
    String _formatDateForApi(String input) {
      final parts = input.split(' / ');
      return "${parts[2]}-${parts[1]}-${parts[0]}";
    }

    // Format waktu untuk API
    String _formatTime(String time12h) {
      time12h = time12h.replaceAll(RegExp(r'\s+'), ' ').trim();
      final dateTime = DateFormat('h:mm a').parse(time12h);
      return DateFormat('HH:mm:ss').format(dateTime);
    }

    // Siapkan body request
    final requestBody = {
      'nama_tugas': judul,
      'jam_mulai': _formatTime(jamMulai),
      'tanggal_mulai': _formatDateForApi(tanggalMulai),
      'tanggal_selesai': _formatDateForApi(tanggalSelesai),
      'assignment_mode': assignmentMode,
      'user_id': person != null ? [person] : [],
      'departemen_id': departmentId?.toString() ?? '',
      'lokasi': lokasi,
      'instruksi_tugas': note,
    };

    // Debug: lihat data yang dikirim
    print("DATA KIRIM: $requestBody");

    // Kirim request ke API
    final response = await http.post(
      Uri.parse('$baseUrl/api/tugas'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json', 
      },
      body: jsonEncode(requestBody), 
    );

    final responseBody = json.decode(response.body);
    print("RESPON API: $responseBody"); 

    return {
      'success': response.statusCode == 200,
      'message': responseBody['message'] ?? 'Gagal membuat tugas',
    };
  }

  // Update tugas
  static Future<Map<String, dynamic>> updateTugas({
    required int id,
    required String judul,
    required String jamMulai,
    required String tanggalMulai,
    required String tanggalSelesai,
    required String assignmentMode,
    int? person,
    int? departmentId,
    required String lokasi,
    required String note,
  }) async {
    final token = await _getToken();
    if (token == null) throw Exception('Token tidak ditemukan. Harap login ulang.');

    // Format tanggal untuk API
    String _formatDateForApi(String input) {
      input = input.trim();
      // Jika format sudah YYYY-MM-DD, kembalikan apa adanya
      if (RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(input)) return input;

      // Jika format dd / mm / yyyy
      final parts = input.split(RegExp(r'\s*/\s*')); // split dengan / dan hilangkan spasi
      if (parts.length == 3) {
        return "${parts[2]}-${parts[1].padLeft(2,'0')}-${parts[0].padLeft(2,'0')}";
      }
      return input;
    }

    // Format waktu untuk API
    String _formatTime(String time) {
      time = time.trim();

      // Jika sudah HH:mm:ss, kembalikan apa adanya
      if (RegExp(r'^\d{1,2}:\d{2}:\d{2}$').hasMatch(time)) {
        return time;
      }

      // Jika HH:mm, tambahkan ":00"
      if (RegExp(r'^\d{1,2}:\d{2}$').hasMatch(time)) {
        return '$time:00';
      }

      // Kalau masih 12 jam (1:16 PM), parse dengan jm
      try {
        final dateTime = DateFormat.jm().parse(time);
        return DateFormat('HH:mm:ss').format(dateTime);
      } catch (e) {
        return time;
      }
    }

    final requestBody = {
      'nama_tugas': judul,
      'jam_mulai': _formatTime(jamMulai),
      'tanggal_mulai': _formatDateForApi(tanggalMulai),
      'tanggal_selesai': _formatDateForApi(tanggalSelesai),
      'assignment_mode': assignmentMode,
      'user_id': assignmentMode == 'Per User' ? [person] : null,
      'departemen_id': assignmentMode == 'Per Departemen' ? departmentId : null,
      'lokasi': lokasi,
      'instruksi_tugas': note,
    };

    // Debug: lihat data yang dikirim
    print("DATA KIRIM: $requestBody");

    final response = await http.put(
      Uri.parse('$baseUrl/api/tugas/$id'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );

    final responseBody = json.decode(response.body);
    print("RESPON API: $responseBody"); 

    return {
      'success': response.statusCode == 200,
      'message': responseBody['message'] ?? 'Gagal update tugas',
    };
  }

  // Delete tugas
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
      'message': body['message'] ??
          (response.statusCode == 200
              ? 'Tugas berhasil dihapus'
              : 'Gagal menghapus tugas'),
    };
  }
}