import 'package:musliemapp/features/prayer/domain/entities/prayer_item.dart';

class PrayerModel extends PrayerItem {
  PrayerModel({required super.text});

  factory PrayerModel.fromJson(Map<String, dynamic> json) {
    return PrayerModel(text: json['text'] ?? '');
  }
}
