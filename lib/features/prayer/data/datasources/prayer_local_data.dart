import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:musliemapp/features/prayer/data/models/prayer_model.dart';

class PrayerLocalData {
  Future<List<PrayerModel>> getPrayerItems(String jsonFile) async {
    final jsonString = await rootBundle.loadString(jsonFile);
    List<dynamic> data = jsonDecode(jsonString);
    return data.map((e) => PrayerModel.fromJson(e)).toList();
  }
}
