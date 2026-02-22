import 'package:musliemapp/features/hadith/domain/entities/nawawi.dart';

class NawawiModel extends Nawawi {
  NawawiModel({required super.description, required super.hadith, super.title});

  factory NawawiModel.fromJson(Map<String, dynamic> json) {
    return NawawiModel(
      description: json['description'],
      hadith: json['hadith'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'description': description, 'hadith': hadith, 'title': title};
  }
}
