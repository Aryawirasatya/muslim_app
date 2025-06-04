import 'package:flutter/material.dart';
import '../model/doa_model.dart';

class DetailDoaScreen extends StatelessWidget {
  final Doa doa;

  const DetailDoaScreen({super.key, required this.doa});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          doa.doa ?? "Detail Doa",
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.teal.shade700,
        centerTitle: true,
        elevation: 6,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Ayat Arab
            Text(
              doa.ayat ?? "Tidak ada ayat",
              style: const TextStyle(
                fontSize: 32,
                fontFamily: 'Arabic',
                fontWeight: FontWeight.bold,
                height: 1.5,
                color: Colors.teal,
              ),
              textAlign: TextAlign.right,
            ),

            const SizedBox(height: 24),

            // Latin / transliterasi
            Text(
              doa.latin ?? "Tidak ada transliterasi",
              style: TextStyle(
                fontSize: 20,
                fontStyle: FontStyle.italic,
                color: Colors.grey.shade800,
                height: 1.4,
              ),
              textAlign: TextAlign.left,
            ),

            const SizedBox(height: 24),

            // Terjemahan
            Text(
              "Artinya:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.teal.shade900,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              doa.artinya ?? "Tidak ada terjemahan",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade700,
                height: 1.4,
              ),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
