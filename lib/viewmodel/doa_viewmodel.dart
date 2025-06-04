import 'package:flutter/material.dart';
import '../model/doa_model.dart';
import '../core/network/api_service.dart';

class DoaViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Doa> doaList = [];
  bool isLoading = false;
  String errorMessage = "";

  /// 🔹 Ambil daftar doa dari API
  Future<void> getDoaList() async {
    try {
      isLoading = true;
      errorMessage = "";
      notifyListeners();

      final List<dynamic> response = await _apiService.fetchDoa();
      doaList = response.map((data) => Doa.fromJson(data)).toList();

      if (doaList.isEmpty) {
        errorMessage = "Tidak ada doa tersedia.";
      }
    } catch (e) {
      errorMessage = "Gagal memuat doa: $e";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
