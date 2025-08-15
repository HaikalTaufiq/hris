import 'package:flutter/material.dart';
import 'package:hr/data/models/cuti_model.dart';
import 'package:hr/data/services/cuti_service.dart';

class CutiProvider with ChangeNotifier {
  List<CutiModel> _cutiList = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<CutiModel> get cutiList => _cutiList;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// Ambil semua data cuti dari API
  Future<void> fetchCuti() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _cutiList = await CutiService.fetchCuti();
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  /// Tambah cuti baru
  Future<bool> createCuti({
    required String nama,
    required String tipeCuti,
    required String tanggalMulai,
    required String tanggalSelesai,
    required String alasan,
  }) async {
    final success = await CutiService.createCuti(
      nama: nama,
      tipeCuti: tipeCuti,
      tanggalMulai: tanggalMulai,
      tanggalSelesai: tanggalSelesai,
      alasan: alasan,
    );

    if (success) {
      await fetchCuti(); // refresh data
    }

    return success;
  }

  /// Edit cuti
  Future<Map<String, dynamic>> editCuti({
    required int id,
    required String nama,
    required String tipeCuti,
    required String tanggalMulai,
    required String tanggalSelesai,
    required String alasan,
  }) async {
    final result = await CutiService.editCuti(
      id: id,
      nama: nama,
      tipeCuti: tipeCuti,
      tanggalMulai: tanggalMulai,
      tanggalSelesai: tanggalSelesai,
      alasan: alasan,
    );

    if (result['success'] == true) {
      await fetchCuti(); // refresh data
    }

    return result;
  }

  /// Hapus cuti
  Future<String> deleteCuti(int id) async {
    final result = await CutiService.deleteCuti(id);
    await fetchCuti();
    return result['message'] ?? 'Tidak ada pesan';
  }

  /// Approve cuti
  Future<String?> approveCuti(int id) async {
    final message = await CutiService.approveCuti(id);
    await fetchCuti();
    return message;
  }

  /// Decline cuti
  Future<String?> declineCuti(int id) async {
    final message = await CutiService.declineCuti(id);
    await fetchCuti();
    return message;
  }
}
