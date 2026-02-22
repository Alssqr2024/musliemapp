class Qudsi {
  final int id;
  final int idInBook;
  final int chapterId;
  final int bookId;
  final String arabic;
  final English english;
  String? title;

  Qudsi({
    required this.id,
    required this.idInBook,
    required this.chapterId,
    required this.bookId,
    required this.arabic,
    required this.english,
    this.title,
  });
}

class English {
  final String narrator;
  final String text;

  English({required this.narrator, required this.text});

  factory English.fromJson(Map<String, dynamic> json) {
    return English(narrator: json['narrator'] ?? "", text: json['text'] ?? "");
  }
}
