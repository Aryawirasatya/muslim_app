import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/jadwal_shalat_model.dart';

class DetailJadwalScreen extends StatelessWidget {
  final Jadwal jadwal;

  const DetailJadwalScreen({super.key, required this.jadwal});

  Widget _buildJadwalItem(IconData icon, String label, String waktu) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: Colors.teal.shade700, size: 32),
        title: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        trailing: Text(
          waktu,
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Jadwal - ${jadwal.tanggal}"),
        backgroundColor: Colors.teal.shade700,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Tanggal: ${jadwal.tanggal}",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade900,
              ),
            ),
            const SizedBox(height: 20),

            _buildJadwalItem(Icons.access_time_filled, "Imsak", jadwal.imsak ?? "-"),
            _buildJadwalItem(Icons.wb_sunny_outlined, "Subuh", jadwal.subuh ?? "-"),
            _buildJadwalItem(Icons.wb_twilight, "Terbit", jadwal.terbit ?? "-"),
            _buildJadwalItem(Icons.brightness_5_outlined, "Dhuha", jadwal.dhuha ?? "-"),
            _buildJadwalItem(Icons.nightlight_round, "Dzuhur", jadwal.dzuhur ?? "-"),
            _buildJadwalItem(Icons.wb_sunny, "Ashar", jadwal.ashar ?? "-"),
            _buildJadwalItem(Icons.wb_twilight_outlined, "Maghrib", jadwal.maghrib ?? "-"),
            _buildJadwalItem(Icons.nights_stay, "Isya", jadwal.isya ?? "-"),

          ],
        ),
      ),
    );
  }
}
