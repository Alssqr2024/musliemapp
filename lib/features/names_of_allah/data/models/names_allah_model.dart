import 'package:musliemapp/features/names_of_allah/domain/entities/names_allah.dart';

class NamesAllahModel extends NamesAllah {
  NamesAllahModel({
    required super.id,
    required super.name,
    required super.text,
  });

  factory NamesAllahModel.fromJson(Map<String, dynamic> json) {
    return NamesAllahModel(
      id: json['id'],
      name: json['name'],
      text: json['text'],
    );
  }

  Map<String, dynamic> tojson() {
    return {"id": id, "name": name, "text": text};
  }
}
