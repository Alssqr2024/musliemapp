import 'package:get/get.dart';
import 'package:musliemapp/features/prayer_times/presentation/controllers/prayer_times_controller.dart';

/// Binding for PrayerTimesController
/// This controller is initialized early as it's used in HomePage
class PrayerTimesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PrayerTimesController>(
      () => PrayerTimesController(),
      fenix: true, // Keep in memory even after disposal
    );
  }
}
