class Azkar {
  final int id;
  final String category;
  final String audio;
  final String filename;
  final List<Array> array;

  Azkar({
    required this.id,
    required this.category,
    required this.audio,
    required this.filename,
    required this.array,
  });
}

class Array {
  final int id;
  final String text;
  int count;
  final String filename;

  Array({
    required this.id,
    required this.text,
    required this.count,
    required this.filename,
  });

  factory Array.fromJson(Map<String, dynamic> json) {
    return Array(
      id: json["id"] ?? "",
      text: json["text"] ?? "",
      count: json["count"] ?? 0,
      filename: json["filename"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "text": text, "count": count, "filename": filename};
  }
}
