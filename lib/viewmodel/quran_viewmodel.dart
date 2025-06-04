// lib/viewmodel/quran_viewmodel.dart

import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/quran_model.dart'; // model Surah detail
import 'package:flutter_application_1/model/chapter_model.dart'; // model Chapter baru
import '../core/network/api_service.dart';

class QuranViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  // State untuk detail surah (ayat per surah)
  Surah? surah;           // dari model quran_model.dart
  bool isLoadingSurah = false;
  String errorMessageSurah = "";

  // State untuk daftar chapter (daftar surah)
  List<Chapter> chapters = [];
  bool isLoadingChapters = false;
  String errorMessageChapters = "";

  /// 🔹 Ambil detail surah (ayat per surah)
  Future<void> getSurahDetail(int surahId) async {
    try {
      isLoadingSurah = true;
      errorMessageSurah = "";
      notifyListeners();

      final response = await _apiService.fetchSurah(surahId);
      surah = Surah.fromJson(response);
    } catch (e) {
      errorMessageSurah = "Gagal memuat data surah: $e";
    } finally {
      isLoadingSurah = false;
      notifyListeners();
    }
  }

  /// 🔹 Ambil daftar chapter (daftar surah)
  Future<void> getChapters() async {
    try {
      isLoadingChapters = true;
      errorMessageChapters = "";
      notifyListeners();

      final response = await _apiService.fetchChapters();
      if (response['chapters'] != null) {
        final List<dynamic> list = response['chapters'] as List<dynamic>;
        chapters = list.map((e) => Chapter.fromJson(e as Map<String, dynamic>)).toList();
      } else {
        chapters = [];
        errorMessageChapters = "Response chapters kosong";
      }
    } catch (e) {
      errorMessageChapters = "Gagal memuat daftar surah: $e";
    } finally {
      isLoadingChapters = false;
      notifyListeners();
    }
  }
}
