import 'package:musliemapp/core/utils/json_loader.dart';
import 'package:musliemapp/features/prayer/data/models/prayer_model.dart';

class PrayerLocalData {
  Future<List<PrayerModel>> getPrayerItems(String jsonFile) async {
    final data = await JsonLoader.loadList(jsonFile);
    try {
      return data.map((e) => PrayerModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (_) {
      return [];
    }
  }
}
