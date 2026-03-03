import 'package:get/get.dart';
import 'package:musliemapp/features/prayer/data/datasources/prayer_local_data.dart';
import 'package:musliemapp/features/prayer/data/repositories/prayer_repo_impl.dart';
import 'package:musliemapp/features/prayer/domain/usecases/get_prayer_items_usecase.dart';

/// Binding for Prayer (Duas) feature - يسجل الاعتماديات فقط، الـ Controller يُسجل في الصفحة مع tag
class PrayerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PrayerLocalData(), fenix: true);
    Get.lazyPut(
      () => PrayerRepoImpl(localData: Get.find<PrayerLocalData>()),
      fenix: true,
    );
    Get.lazyPut(
      () => GetPrayerItemsUseCase(prayerRepo: Get.find<PrayerRepoImpl>()),
      fenix: true,
    );
  }
}
