import 'package:musliemapp/features/prayer/domain/entities/prayer_item.dart';
import 'package:musliemapp/features/prayer/domain/repositories/prayer_repo.dart';

class GetPrayerItemsUseCase {
  final PrayerRepo prayerRepo;

  GetPrayerItemsUseCase({required this.prayerRepo});

  Future<List<PrayerItem>> call(String jsonFile) async {
    return await prayerRepo.getPrayerItems(jsonFile);
  }
}
