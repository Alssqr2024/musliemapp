import 'package:musliemapp/features/azkar/domain/entities/azkar.dart';

class AzkarModel extends Azkar {
  AzkarModel({
    required super.id,
    required super.category,
    required super.audio,
    required super.filename,
    required super.array,
  });

  factory AzkarModel.fromJson(Map<String, dynamic> json) {
    return AzkarModel(
      id: json["id"],
      category: json["category"],
      audio: json["audio"],
      filename: json["filename"],
      array: (json["array"] as List).map((e) => Array.fromJson(e)).toList(),
    );
  }
}
