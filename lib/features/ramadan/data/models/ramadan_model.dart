import 'package:musliemapp/features/ramadan/domain/entities/ramadan_item.dart';

class RamadanModel extends RamadanItem {
  RamadanModel({required super.title, required super.content});

  factory RamadanModel.fromJson(Map<String, dynamic> json) {
    return RamadanModel(
      title: json['number'] ?? '',
      content: json['label'] ?? '',
    );
  }
}
