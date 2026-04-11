import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kIsWeb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_widget/home_widget.dart';
import 'package:musliemapp/core/constants/app_settings_keys.dart';
import 'package:musliemapp/features/prayer_times/presentation/controllers/prayer_times_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsController extends GetxController {
  final notifyPrayer = true.obs;
  final notifyQuranDaily = false.obs;
  final locationOnline = true.obs;
  final quranHour = 8.obs;
  final quranMinute = 0.obs;

  late final TextEditingController manualLatController;
  late final TextEditingController manualLonController;
  late final TextEditingController manualLabelController;

  @override
  void onInit() {
    super.onInit();
    manualLatController = TextEditingController();
    manualLonController = TextEditingController();
    manualLabelController = TextEditingController();
    _loadPrefs();
  }

  @override
  void onClose() {
    manualLatController.dispose();
    manualLonController.dispose();
    manualLabelController.dispose();
    super.onClose();
  }

  Future<void> _loadPrefs() async {
    final p = await SharedPreferences.getInstance();
    notifyPrayer.value = p.getBool(AppSettingsKeys.notifyPrayer) ?? true;
    notifyQuranDaily.value =
        p.getBool(AppSettingsKeys.notifyQuranDaily) ?? false;
    final mode = p.getString(AppSettingsKeys.locationMode) ??
        AppSettingsKeys.locationModeOnline;
    locationOnline.value = mode == AppSettingsKeys.locationModeOnline;
    quranHour.value = p.getInt(AppSettingsKeys.quranReminderHour) ?? 8;
    quranMinute.value = p.getInt(AppSettingsKeys.quranReminderMinute) ?? 0;

    final lat = p.getDouble(AppSettingsKeys.manualLat);
    final lon = p.getDouble(AppSettingsKeys.manualLon);
    manualLatController.text = lat?.toString() ?? '';
    manualLonController.text = lon?.toString() ?? '';
    manualLabelController.text = p.getString(AppSettingsKeys.manualLabel) ?? '';
  }

  Future<void> _persistAndSyncNotifications() async {
    if (Get.isRegistered<PrayerTimesController>()) {
      await Get.find<PrayerTimesController>().syncNotificationSettings();
    }
  }

  Future<void> setNotifyPrayer(bool value) async {
    notifyPrayer.value = value;
    final p = await SharedPreferences.getInstance();
    await p.setBool(AppSettingsKeys.notifyPrayer, value);
    await _persistAndSyncNotifications();
  }

  Future<void> setNotifyQuranDaily(bool value) async {
    notifyQuranDaily.value = value;
    final p = await SharedPreferences.getInstance();
    await p.setBool(AppSettingsKeys.notifyQuranDaily, value);
    await _persistAndSyncNotifications();
  }

  Future<void> setLocationOnline(bool online) async {
    locationOnline.value = online;
    final p = await SharedPreferences.getInstance();
    await p.setString(
      AppSettingsKeys.locationMode,
      online
          ? AppSettingsKeys.locationModeOnline
          : AppSettingsKeys.locationModeManual,
    );
    if (Get.isRegistered<PrayerTimesController>()) {
      await Get.find<PrayerTimesController>().loadPrayerTimes();
    }
  }

  Future<void> saveQuranReminderTime(int hour, int minute) async {
    quranHour.value = hour;
    quranMinute.value = minute;
    final p = await SharedPreferences.getInstance();
    await p.setInt(AppSettingsKeys.quranReminderHour, hour);
    await p.setInt(AppSettingsKeys.quranReminderMinute, minute);
    if (notifyQuranDaily.value) {
      await _persistAndSyncNotifications();
    }
  }

  Future<bool> saveManualLocation() async {
    final lat = double.tryParse(
      manualLatController.text.trim().replaceAll(',', '.'),
    );
    final lon = double.tryParse(
      manualLonController.text.trim().replaceAll(',', '.'),
    );
    if (lat == null ||
        lon == null ||
        lat < -90 ||
        lat > 90 ||
        lon < -180 ||
        lon > 180) {
      Get.snackbar(
        'تنبيه',
        'أدخل خط عرض وطول صحيحين (مثال: 24.7136، 46.6753).',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
    final p = await SharedPreferences.getInstance();
    await p.setDouble(AppSettingsKeys.manualLat, lat);
    await p.setDouble(AppSettingsKeys.manualLon, lon);
    await p.setString(
      AppSettingsKeys.manualLabel,
      manualLabelController.text.trim(),
    );
    if (Get.isRegistered<PrayerTimesController>()) {
      await Get.find<PrayerTimesController>().loadPrayerTimes();
    }
    Get.snackbar(
      'تم',
      'حُفظ الموقع اليدوي.',
      snackPosition: SnackPosition.BOTTOM,
    );
    return true;
  }

  static const String _calendarWidgetQualified =
      'com.alssqr.musliemapp.CalendarWidgetProvider';
  static const String _prayerTimesWidgetQualified =
      'com.alssqr.musliemapp.PrayerTimesWidgetProvider';

  /// طلب تثبيت ويدجت التقويم على الشاشة الرئيسية (أندرويد 8+، إن دعم المشغّل ذلك).
  Future<void> requestPinCalendarHomeWidget() async {
    await _requestPinHomeWidget(
      qualifiedAndroidName: _calendarWidgetQualified,
      shortName: 'التقويم',
    );
  }

  /// طلب تثبيت ويدجت مواقيت الصلاة على الشاشة الرئيسية.
  Future<void> requestPinPrayerTimesHomeWidget() async {
    await _requestPinHomeWidget(
      qualifiedAndroidName: _prayerTimesWidgetQualified,
      shortName: 'مواقيت الصلاة',
    );
  }

  Future<void> _requestPinHomeWidget({
    required String qualifiedAndroidName,
    required String shortName,
  }) async {
    if (kIsWeb || defaultTargetPlatform != TargetPlatform.android) {
      Get.snackbar(
        'تنبيه',
        'إضافة الويدجت من الإعدادات متاحة على أندرويد.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    try {
      final supported = await HomeWidget.isRequestPinWidgetSupported();
      if (supported == true) {
        await HomeWidget.requestPinWidget(
          qualifiedAndroidName: qualifiedAndroidName,
        );
        Get.snackbar(
          'إضافة الويدجت',
          'إن ظهرت نافذة النظام فوافق لإضافة ويدجت $shortName. وإلا استخدم «كيف أضيفها يدوياً؟».',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5),
        );
      } else {
        showHomeWidgetManualInstructions();
      }
    } catch (_) {
      Get.snackbar(
        'تنبيه',
        'تعذّر طلب إضافة الويدجت. جرّب «كيف أضيفها يدوياً؟».',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void showHomeWidgetManualInstructions() {
    Get.snackbar(
      'إضافة يدوية',
      'اضغط مطولاً على الشاشة الرئيسية ← ويدجتات ← ابحث عن «أذكار المسلم» ثم اختر ويدجت التقويم أو مواقيت الصلاة واسحبه إلى الشاشة.',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 6),
    );
  }
}
