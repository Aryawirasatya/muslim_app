// lib/views/detail_surah_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/chapter_model.dart';
import 'package:flutter_application_1/viewmodel/quran_viewmodel.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:provider/provider.dart';

class DetailSurahScreen extends StatefulWidget {
  final int surahNumber;

  const DetailSurahScreen({super.key, required this.surahNumber});

  @override
  _DetailSurahScreenState createState() => _DetailSurahScreenState();
}

class _DetailSurahScreenState extends State<DetailSurahScreen> {
  @override
  void initState() {
    super.initState();
    // Setelah widget terpasang, panggil ViewModel untuk ambil detail
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final vm = Provider.of<QuranViewModel>(context, listen: false);
      // Pastikan chapters sudah diambil, kalau belum, panggil juga
      if (vm.chapters.isEmpty) {
        vm.getChapters().then((_) {
          vm.getSurahDetail(widget.surahNumber);
        });
      } else {
        vm.getSurahDetail(widget.surahNumber);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<QuranViewModel>(context);

    // Cari data chapter untuk judul Arab, Latin, dan terjemahan judul
    String judulLatin = "";
    String judulTerjemahan = "";
    String jenis = ""; // Makkiyah / Madaniyah

    if (viewModel.chapters.isNotEmpty) {
      final chap = viewModel.chapters.firstWhere(
        (c) => c.id == widget.surahNumber,
        orElse: () => Chapter(
          id: widget.surahNumber,
          nameArabic: "",
          nameSimple: "",
          translatedName: "",
          versesCount: 0,
          revelationPlace: "",
        ),
      );
      judulLatin = chap.nameSimple;
   
    }

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            if (judulLatin.isNotEmpty)
              Text(
                judulLatin,
                style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
            if (judulTerjemahan.isNotEmpty)
              Text(
                judulTerjemahan,
                style: const TextStyle(fontSize: 14, color: Colors.white70),
              ),
            if (jenis.isNotEmpty)
              Text(
                jenis,
                style: const TextStyle(fontSize: 12, color: Colors.white60),
              ),
          ],
        ),
      ),
      body: SafeArea(
        child: viewModel.isLoadingSurah
            ? const Center(child: CircularProgressIndicator())
            : viewModel.errorMessageSurah.isNotEmpty
                ? Center(
                    child: Text(
                      viewModel.errorMessageSurah,
                      textAlign: TextAlign.center,
                    ),
                  )
                : (viewModel.surah?.verses == null || viewModel.surah!.verses!.isEmpty)
                    ? const Center(child: Text("Tidak ada data ayat"))
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        itemCount: viewModel.surah!.verses!.length,
                       itemBuilder: (context, index) {
                          final verse = viewModel.surah!.verses![index];
                          final arabText = verse.words?.map((w) => w.textUthmani).join(" ") ?? "";
                          final latinText = verse.words
                            ?.where((w) => w.transliteration != null)
                            .map((w) => w.transliteration!)
                            .join(" ") ?? "";

                          final terjemahan = verse.translations?.map((t) => t.text).join(" ") ?? "";

                          return Card(
                            elevation: 2,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: CircleAvatar(
                                      radius: 12,
                                      backgroundColor: Colors.grey.shade200,
                                      child: Text(
                                        '${index + 1}',
                                        style: const TextStyle(fontSize: 12, color: Colors.black87),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  if (arabText.isNotEmpty)
                                    Text(
                                      arabText,
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Arabic',
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                  const SizedBox(height: 8),
                                  if (latinText.isNotEmpty)
                                    Text(
                                      latinText,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.black87,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  const SizedBox(height: 8),
                                  if (terjemahan.isNotEmpty)
                                  Html(
                                    data: terjemahan,
                                    style: {
                                      "*": Style(
                                        fontSize: FontSize(16),
                                        color: Colors.black54,
                                      ),
                                      "body": Style(
                                        margin: Margins.zero,
                                        padding: HtmlPaddings.zero,
                                      ),
                                    },
                                  ),

                                ],
                              ),
                            ),
                          );
                        }

                      ),
      ),
    );
  }
}
