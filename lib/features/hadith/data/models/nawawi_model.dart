import 'package:musliemapp/features/hadith/domain/entities/nawawi.dart';

class NawawiModel extends Nawawi {
  NawawiModel({required super.description, required super.hadith});

  factory NawawiModel.fromJson(Map<String, dynamic> json) {
    return NawawiModel(
      description: json['description'],
      hadith: json['hadith'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'description': description, 'hadith': hadith};
  }
}
