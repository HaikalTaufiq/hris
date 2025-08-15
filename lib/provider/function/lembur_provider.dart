import 'package:flutter/material.dart';
import 'package:hr/data/models/lembur_model.dart';
import 'package:hr/data/services/lembur_service.dart';

class LemburProvider extends ChangeNotifier {
  List<LemburModel> _lemburList = [];
  bool _isLoading = false;
  String? _errorMessage;
  List<LemburModel> get lemburList => _lemburList;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  void setError(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // Fetch semua lembur
  Future<void> fetchLembur() async {
    _isLoading = true;
    notifyListeners();

    try {
      _lemburList = await LemburService.fetchLembur();
    } catch (e) {
      print('Error fetch lembur: $e');
      _lemburList = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  // Create lembur
  Future<bool> createLembur({
    required String tanggal,
    required String jamMulai,
    required String jamSelesai,
    required String deskripsi,
  }) async {
    final success = await LemburService.createLembur(
      tanggal: tanggal,
      jamMulai: jamMulai,
      jamSelesai: jamSelesai,
      deskripsi: deskripsi,
    );

    if (success) {
      await fetchLembur(); // Refresh list setelah create
    }
    return success;
  }

  // Edit lembur
  Future<Map<String, dynamic>> editLembur({
    required int id,
    required String tanggal,
    required String jamMulai,
    required String jamSelesai,
    required String deskripsi,
  }) async {
    final result = await LemburService.editLembur(
      id: id,
      tanggal: tanggal,
      jamMulai: jamMulai,
      jamSelesai: jamSelesai,
      deskripsi: deskripsi,
    );

    if (result['success'] == true) {
      await fetchLembur(); // Refresh list setelah edit
    }

    return result;
  }

  // Delete lembur
  Future<String?> deleteLembur(int id) async {
    final result = await LemburService.deleteLembur(id);
    await fetchLembur(); // Refresh list setelah delete
    return result['message'];
  }

  // Approve lembur
  Future<String?> approveLembur(int id) async {
    final message = await LemburService.approveLembur(id);
    await fetchLembur(); // Refresh list setelah approve
    return message;
  }

  // Decline lembur
  Future<String?> declineLembur(int id) async {
    final message = await LemburService.declineLembur(id);
    await fetchLembur(); // Refresh list setelah decline
    return message;
  }
}
