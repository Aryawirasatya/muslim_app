class Surah {
  List<Verses>? verses;
  Meta? meta;

  Surah({this.verses, this.meta});

  factory Surah.fromJson(Map<String, dynamic> json) {
    return Surah(
      verses: json['verses'] != null
          ? (json['verses'] as List).map((v) => Verses.fromJson(v)).toList()
          : [],
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'verses': verses?.map((v) => v.toJson()).toList(),
      'meta': meta?.toJson(),
    };
  }
}

class Verses {
  final int? id;
  final String? verseKey;
  final List<Word>? words;
  final List<Translation>? translations;

  Verses({this.id, this.verseKey, this.words, this.translations});

  factory Verses.fromJson(Map<String, dynamic> json) {
    var wordsList = json['words'] as List<dynamic>?;
    var translationsList = json['translations'] as List<dynamic>?;

    return Verses(
      id: json['id'] as int?,
      verseKey: json['verse_key'] as String?,
      words: wordsList != null
          ? wordsList.map((e) => Word.fromJson(e as Map<String, dynamic>)).toList()
          : [],
      translations: translationsList != null
          ? translationsList.map((e) => Translation.fromJson(e as Map<String, dynamic>)).toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'verse_key': verseKey,
      'words': words?.map((e) => e.toJson()).toList(),
      'translations': translations?.map((e) => e.toJson()).toList(),
    };
  }
}


class Meta {
  Filters? filters;

  Meta({this.filters});

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      filters: json['filters'] != null ? Filters.fromJson(json['filters']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'filters': filters?.toJson(),
    };
  }
}

class Filters {
  String? chapterNumber;

  Filters({this.chapterNumber});

  factory Filters.fromJson(Map<String, dynamic> json) {
    return Filters(
      chapterNumber: json['chapter_number'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chapter_number': chapterNumber,
    };
  }
}


class Word {
  final String? textUthmani;
  final String? transliteration;

  Word({this.textUthmani, this.transliteration});

  factory Word.fromJson(Map<String, dynamic> json) {
    return Word(
      textUthmani: json['text_uthmani'] as String?,
      transliteration: json['transliteration']?['text'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text_uthmani': textUthmani,
      'transliteration': {'text': transliteration},
    };
  }
}

class Translation {
  final String? text;

  Translation({this.text});

  factory Translation.fromJson(Map<String, dynamic> json) {
    return Translation(
      text: json['text'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
    };
  }
}



