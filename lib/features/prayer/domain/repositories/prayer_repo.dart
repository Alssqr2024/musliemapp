import 'package:musliemapp/features/prayer/domain/entities/prayer_item.dart';

abstract class PrayerRepo {
  Future<List<PrayerItem>> getPrayerItems(String jsonFile);
}
