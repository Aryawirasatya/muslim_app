// lib/views/splash_screen.dart

import 'package:flutter/material.dart';
import 'dart:async';
import 'nav_wrapper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

// Ganti SingleTickerProviderStateMixin → TickerProviderStateMixin
class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _iconController;
  late Animation<double> _iconAnimation;
  late AnimationController _textController;
  late Animation<double> _textAnimation;

  @override
  void initState() {
    super.initState();

    // ─── Animasi ikon (pulsing) ────────────────────────────────────────────────
    _iconController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _iconAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _iconController, curve: Curves.easeInOut),
    );

    // ─── Animasi teks (fade in) ───────────────────────────────────────────────
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
    _textAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeIn),
    );
    // Mulai fade-in setelah 0.5 detik
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) _textController.forward();
    });

    // ─── Navigasi otomatis setelah 3 detik ─────────────────────────────────────
    Timer(const Duration(seconds: 3), () {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => const NavWrapper()),
  );
});

  }

  @override
  void dispose() {
    _iconController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ─── Gradient Background ───────────────────────────────────────────────────
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0D3B66), // biru tua
              Color(0xFF218380), // teal
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ─── Ikon Masjid dengan animasi pulsing ───────────────────────────────
              ScaleTransition(
                scale: _iconAnimation,
                child: const Icon(
                  Icons.mosque,
                  size: 100,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              // ─── Teks judul dengan fade-in ────────────────────────────────────────
              FadeTransition(
                opacity: _textAnimation,
                child: const Text(
                  "Aplikasi Muslim",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // ─── Subteks dengan fade-in lambat ─────────────────────────────────────
              FadeTransition(
                opacity: _textAnimation,
                child: const Text(
                  "Menuju keberkahan bersama",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              // ─── Loading indicator sederhana ───────────────────────────────────────
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
