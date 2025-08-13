import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class AuthService {
  final String baseUrl = 'http://192.168.20.50:8000';

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final user = UserModel.fromJson(data['data']);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', data['token']); 
      await prefs.setString('nama', user.nama); 
      await prefs.setString('email', user.email);
      await prefs.setString('jenis_kelamin', user.jenisKelamin);
      await prefs.setString('status_pernikahan', user.statusPernikahan);
      await prefs.setString('peran', user.peran.namaPeran);
      await prefs.setString('departemen',user.departemen.namaDepartemen);

      return {
        'success': true,
        'token': data['token'],
        'user': user,
        'message': data['message'],
      };
    } else {
      return {
        'success': false,
        'message': jsonDecode(response.body)['message'],
      };
    }
  }

  // ✅ Logout
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('nama');
    await prefs.remove('peran');
  }

  // ✅ Ambil token
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // ✅ Ambil nama
  Future<String?> getNama() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('nama');
  }

  // ✅ Ambil peran
  Future<String?> getPeran() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('peran');
  }
}
