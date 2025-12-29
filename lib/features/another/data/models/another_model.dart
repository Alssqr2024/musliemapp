import 'package:musliemapp/features/another/domain/entities/another_item.dart';

class AnotherModel extends AnotherItem {
  AnotherModel({required super.title, required super.content});

  factory AnotherModel.fromJson(Map<String, dynamic> json) {
    return AnotherModel(
      title: json['number'] ?? '',
      content: json['label'] ?? '',
    );
  }
}
