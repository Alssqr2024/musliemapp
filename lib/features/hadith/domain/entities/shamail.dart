class Shamail {
  final List<MetaData> metadata;
  final List<Chapters> chapters;
  final List<Hadiths> hadiths;

  Shamail({
    required this.metadata,
    required this.chapters,
    required this.hadiths,
  });
}

//------------------------subclass-------------------------------------//
class MetaData {
  final String title;
  final String author;
  final String introduction;

  MetaData({
    required this.title,
    required this.author,
    required this.introduction,
  });

  factory MetaData.fromJson(Map<String, dynamic> json) {
    return MetaData(
      title: json['title'] ?? "",
      author: json['author'] ?? "",
      introduction: json['introduction'] ?? "",
    );
  }
}

class Arabic {
  String title;
  String author;
  String introduction;

  Arabic({
    required this.title,
    required this.author,
    required this.introduction,
  });

  factory Arabic.fromJson(Map<String, dynamic> json) {
    return Arabic(
      title: json['title'] ?? "",
      author: json['author'] ?? "",
      introduction: json['introduction'] ?? "",
    );
  }
}

class English {
  String title;
  String author;
  String introduction;

  English({
    required this.title,
    required this.author,
    required this.introduction,
  });

  factory English.fromJson(Map<String, dynamic> json) {
    return English(
      title: json['title'] ?? "",
      author: json['author'] ?? "",
      introduction: json['introduction'] ?? "",
    );
  }
}

class Chapters {
  final int id;
  final int bookId;
  final String arabic;
  final String english;

  Chapters({
    required this.id,
    required this.bookId,
    required this.arabic,
    required this.english,
  });

  factory Chapters.fromJson(Map<String, dynamic> json) {
    return Chapters(
      id: json['id'] ?? 0,
      bookId: json['bookId'] ?? 0,
      arabic: json['arabic'] ?? "",
      english: json['english'] ?? "",
    );
  }
}

class Hadiths {
  final int id;
  final int idInBook;
  final int chapterId;
  final int bookId;
  final String arabic;
  final EnglishHadith english;

  Hadiths({
    required this.id,
    required this.idInBook,
    required this.chapterId,
    required this.bookId,
    required this.arabic,
    required this.english,
  });

  factory Hadiths.fromJson(Map<String, dynamic> json) {
    return Hadiths(
      id: json['id'] ?? 0,
      idInBook: json['idInBook'] ?? 0,
      chapterId: json['chapterId'] ?? 0,
      bookId: json['bookId'] ?? 0,
      arabic: json['arabic'] ?? "",
      english: EnglishHadith.fromJson(json['english'] ?? {}),
    );
  }
}

class EnglishHadith {
  final String narrator;
  final String text;

  EnglishHadith({required this.narrator, required this.text});

  factory EnglishHadith.fromJson(Map<String, dynamic> json) {
    return EnglishHadith(
      narrator: json['narrator'] ?? "",
      text: json['text'] ?? "",
    );
  }
}
