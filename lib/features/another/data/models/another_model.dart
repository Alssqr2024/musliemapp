import 'package:musliemapp/features/another/domain/entities/another_item.dart';

class AnotherModel extends AnotherItem {
  AnotherModel({required super.title, required super.content});

  factory AnotherModel.fromJson(Map<String, dynamic> json) {
    String? getString(String key) {
      final value = json[key];
      if (value == null) return null;
      final str = value.toString().trim();
      return str.isEmpty ? null : str;
    }

    // Content can be in 'text', 'label', or 'content'
    final String content =
        getString('text') ?? getString('label') ?? getString('content') ?? '';

    // Title can be in 'name', 'number', 'title', or derived from content
    String title =
        getString('name') ?? getString('number') ?? getString('title') ?? '';

    if (title.isEmpty && content.isNotEmpty) {
      // If title is missing, use the first line of content or a slice
      title = content.split('\n').first;
      if (title.length > 50) {
        title = '${title.substring(0, 47)}...';
      }
    }

    return AnotherModel(title: title, content: content);
  }
}
