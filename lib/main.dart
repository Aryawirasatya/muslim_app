import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'views/splash_screen.dart';
import 'viewmodel/doa_viewmodel.dart';
import 'viewmodel/jadwal_shalat_viewmodel.dart';
import 'viewmodel/quran_viewmodel.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) {
            final now = DateTime.now();
            final vm = JadwalShalatViewModel();
            vm.getJadwalShalat(
              lokasiId: 1206,
              tahun: now.year,
              bulan: now.month,
            );
            return vm;
          },
        ),
        ChangeNotifierProvider(create: (_) => QuranViewModel()),
        ChangeNotifierProvider(create: (_) => DoaViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi Muslim',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const SplashScreen(),
    );
  }
}
