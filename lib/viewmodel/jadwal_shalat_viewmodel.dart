import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/jadwal_shalat_model.dart';
import '../core/network/api_service.dart';

class JadwalShalatViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  JadwalShalat? jadwalShalat;
  bool isLoading = true;
  String errorMessage = "";

  Future<void> getJadwalShalat({
  required int lokasiId,
  required int tahun,
  required int bulan,
}) async {
  try {
    isLoading = true;
    errorMessage = "";
    notifyListeners();

    final data = await _apiService.fetchJadwalShalat(
      lokasiId: lokasiId,
      tahun: tahun,
      bulan: bulan,
    );

    jadwalShalat = JadwalShalat.fromJson(data);
  } catch (e) {
    errorMessage = e.toString();
  } finally {
    isLoading = false;
    notifyListeners();
  }
}


 Future<void> refreshJadwal({required int lokasiId}) async {
  final now = DateTime.now();
  await getJadwalShalat(
    lokasiId: lokasiId,
    tahun: now.year,
    bulan: now.month,
  );
}

}
