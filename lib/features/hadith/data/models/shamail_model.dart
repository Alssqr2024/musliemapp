import 'package:musliemapp/features/hadith/domain/entities/shamail.dart';

class ShamailModel extends Shamail {
  ShamailModel({
    required super.metadata,
    required super.chapters,
    required super.hadiths,
  });

  factory ShamailModel.fromJson(Map<String, dynamic> json) {
    return ShamailModel(
      metadata: (json['metadata'] as List)
          .map((e) => MetaData.fromJson(e))
          .toList(),

      chapters: (json['chapters'] as List)
          .map((e) => Chapters.fromJson(e))
          .toList(),

      hadiths: (json['hadiths'] as List)
          .map((e) => Hadiths.fromJson(e))
          .toList(),
    );
  }
}
