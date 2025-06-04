// lib/model/chapter_model.dart

class Chapter {
  final int id;
  final String nameArabic;        // nama Arab
  final String nameSimple;        // nama Latin (misalnya "Al-Fatihah")
  final String translatedName;    // terjemahan judul (ID)
  final int versesCount;          // jumlah ayat
  final String revelationPlace;   // "makkah" atau "madina"

  Chapter({
    required this.id,
    required this.nameArabic,
    required this.nameSimple,
    required this.translatedName,
    required this.versesCount,
    required this.revelationPlace,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      id: json['id'] as int,
      nameArabic: json['name_arabic'] as String? ?? "",
      nameSimple: json['name_simple'] as String? ?? "",
      // Response memiliki nested object translated_name: { "name": "...", "language_name": "indonesia" }
      translatedName: (json['translated_name'] != null)
          ? (json['translated_name']['name'] as String? ?? "")
          : "",
      versesCount: json['verses_count'] as int? ?? 0,
      revelationPlace: json['revelation_place'] as String? ?? "",
    );
  }
}
