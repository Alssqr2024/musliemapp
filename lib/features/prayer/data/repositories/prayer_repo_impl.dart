import 'package:musliemapp/features/prayer/data/datasources/prayer_local_data.dart';
import 'package:musliemapp/features/prayer/data/models/prayer_model.dart';
import 'package:musliemapp/features/prayer/domain/repositories/prayer_repo.dart';

class PrayerRepoImpl implements PrayerRepo {
  final PrayerLocalData localData;

  PrayerRepoImpl({required this.localData});

  @override
  Future<List<PrayerModel>> getPrayerItems(String jsonFile) async {
    return await localData.getPrayerItems(jsonFile);
  }
}
