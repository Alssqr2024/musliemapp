import 'package:get/get.dart';
import 'package:musliemapp/core/bindings/prayer_times_binding.dart';
import 'package:musliemapp/features/settings/presentation/controllers/settings_controller.dart';

/// Main app bindings - initializes core dependencies
/// Only initializes PrayerTimesController here as it's used in HomePage
/// Other bindings are initialized on-demand when their pages are accessed
class AppBindings extends Bindings {
  @override
  void dependencies() {
    // Initialize PrayerTimesController early as it's used in HomePage
    PrayerTimesBinding().dependencies();
    Get.put(SettingsController(), permanent: true);
  }
}
