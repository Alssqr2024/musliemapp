import 'package:musliemapp/features/hadith/domain/entities/qudsi.dart';

class QudsiModel extends Qudsi {
  QudsiModel({
    required super.id,
    required super.idInBook,
    required super.chapterId,
    required super.bookId,
    required super.arabic,
    required super.english,
  });

  factory QudsiModel.fromJson(Map<String, dynamic> json) {
    return QudsiModel(
      id: json['id'] ?? 0,
      idInBook: json['idInBook'] ?? 0,
      chapterId: json['chapterId'] ?? 0,
      bookId: json['bookId'] ?? 0,
      arabic: json['arabic'] ?? "",
      english: English.fromJson(json['english'] ?? {}),
    );
  }
}
