import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'detail_surah_screen.dart';
import 'package:flutter_application_1/viewmodel/quran_viewmodel.dart';
import 'package:flutter_application_1/model/chapter_model.dart';

class ListSurahScreen extends StatefulWidget {
  const ListSurahScreen({super.key});

  @override
  State<ListSurahScreen> createState() => _ListSurahScreenState();
}

class _ListSurahScreenState extends State<ListSurahScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<QuranViewModel>(context, listen: false).getChapters();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<QuranViewModel>(context);

    final backgroundColor = const Color(0xFFCEF0EF); // teal sangat lembut pastel
    final cardColor = Colors.white;                  // putih bersih
    final textPrimary = const Color(0xFF1B1B1B);     // hitam gelap tapi lembut
    final textSecondary = Colors.black54;            // abu gelap transparan
    final iconColor = Colors.black54;                 // abu gelap transparan

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          "Surah",
          style: TextStyle(
            color: Colors.white, // Ganti warna sesuai keinginan
            fontSize: 20, // Sesuaikan ukuran teks jika diperlukan
            fontWeight: FontWeight.bold, // Tambahkan efek bold jika diinginkan
          ),
        ),
        backgroundColor: Colors.teal.shade700,
        centerTitle: true,
        elevation: 6,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      body: SafeArea(
        child: viewModel.isLoadingChapters
            ? const Center(child: CircularProgressIndicator(color: Colors.teal))
            : viewModel.errorMessageChapters.isNotEmpty
                ? Center(
                    child: Text(
                      viewModel.errorMessageChapters,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16, color: Colors.redAccent),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    itemCount: viewModel.chapters.length,
                    itemBuilder: (context, index) {
                      final Chapter chap = viewModel.chapters[index];
                      final String jenis = (chap.revelationPlace.toLowerCase() == "makkah")
                          ? "Makkiyah"
                          : "Madaniyah";

                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 3,
                        color: cardColor,
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                          leading: CircleAvatar(
                            radius: 26,
                            backgroundColor: const Color(0xFFB0BFC5), // abu lembut
                            child: Text(
                              '${chap.id}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: textPrimary,
                              ),
                            ),
                          ),
                          title: Text(
                            chap.nameSimple,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              letterSpacing: 0.5,
                              color: textPrimary,
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              "${chap.translatedName} · $jenis · ${chap.versesCount} ayat",
                              style: TextStyle(
                                color: textSecondary,
                                fontSize: 14,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                            color: iconColor,
                          ),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          onTap: () {
                            PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: DetailSurahScreen(surahNumber: chap.id),
                              withNavBar: true,
                              pageTransitionAnimation: PageTransitionAnimation.cupertino,
                            );
                          },
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
