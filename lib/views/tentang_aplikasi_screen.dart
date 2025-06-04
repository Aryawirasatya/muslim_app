import 'package:flutter/material.dart';

class TentangAplikasiScreen extends StatelessWidget {
  const TentangAplikasiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tentang Aplikasi"),
        backgroundColor: Colors.teal.shade700,
        elevation: 4,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        color: const Color(0xFFF5F7FA),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Icon logo atau ilustrasi
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.teal.shade100,
                boxShadow: [
                  BoxShadow(
                    color: Colors.teal.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(24),
              child: Icon(
                Icons.mobile_friendly_rounded,
                size: 80,
                color: Colors.teal.shade700,
              ),
            ),
            const SizedBox(height: 24),

            const Text(
              "Aplikasi Muslim",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
                letterSpacing: 1,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 12),

            Text(
              "Aplikasi Muslim aoghpogh ahfehfa ghauewghughaughpogusaughaoghsdhdsodshpuads ",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade800,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 24),

            // Versi aplikasi atau copyright
            Text(
              "Versi 1.0.0",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
                fontStyle: FontStyle.italic,
              ),
            ),

            const Spacer(),

            // Footer kecil
            Text(
              "© .",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
