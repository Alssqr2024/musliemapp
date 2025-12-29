import '../../domain/entities/story.dart';

class StoryModel extends Story {
  StoryModel({required super.title, required super.content, super.text});

  factory StoryModel.fromJson(Map<String, dynamic> json) {
    return StoryModel(
      title: json['number'] ?? json['name'] ?? '',
      content: json['label'] ?? json['story'] ?? '',
      text: json['text'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'number': title, 'label': content, 'text': text};
  }
}
