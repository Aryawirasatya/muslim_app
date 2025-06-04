// lib/core/network/api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // 🔹 API Jadwal Shalat (Tetap)
  static const String baseUrlShalat = "https://api.myquran.com/v2/sholat/jadwal/1206/2025/2";

  // 🔹 API Al-Quran (Tetap untuk ayat per-surah)
  static const String baseUrlQuran = "https://api.quran.com/api/v4/quran/verses/uthmani";

  // 🔹 API untuk mengambil daftar chapter (dengan terjemahan Bahasa Indonesia)
  static const String baseUrlChapters = "https://api.quran.com/api/v4/chapters?language=id";

  // 🔹 API Doa (Menggunakan Hanya Ahmad Ramadhan)
  static const String baseUrlDoa = "https://doa-doa-api-ahmadramadhan.fly.dev/api";

  /// 🔹 Fungsi umum untuk mengambil data dari API dengan timeout & error handling
  Future<dynamic> _fetchData(String url) async {
    try {
      print("🔹 Fetching data from: $url");
      final response = await http.get(Uri.parse(url)).timeout(
        const Duration(seconds: 20),
        onTimeout: () {
          throw Exception("⏳ Timeout: Server tidak merespons dalam 20 detik.");
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception("🚫 Gagal memuat data (${response.statusCode})");
      }
    } catch (e) {
      throw Exception("❌ Error fetching data: $e");
    }
  }

  /// 🔹 Ambil data Jadwal Shalat
    Future<Map<String, dynamic>> fetchJadwalShalat({
    required int lokasiId,
    required int tahun,
    required int bulan,
  }) async {
    final url = "https://api.myquran.com/v2/sholat/jadwal/$lokasiId/$tahun/$bulan";
    return await _fetchData(url);
  }


  /// 🔹 Ambil data Surah Al-Quran (Teks Arab Utsmani per surah)
 Future<Map<String, dynamic>> fetchSurah(int surahId) async {
  final url = "https://api.quran.com/api/v4/verses/by_chapter/$surahId?language=id&words=true&translations=33&word_fields=text_uthmani,text_imlaei,transliteration";
  return await _fetchData(url);
}


  /// 🔹 Ambil daftar chapter (surah) dalam Bahasa Indonesia
  Future<Map<String, dynamic>> fetchChapters() async {
    return await _fetchData(baseUrlChapters);
  }

  /// 🔹 Ambil daftar doa dari API Ahmad Ramadhan
  Future<List<dynamic>> fetchDoa() async {
    return await _fetchData(baseUrlDoa);
  }
}
