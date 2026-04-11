import 'package:flutter/foundation.dart';
import 'package:home_widget/home_widget.dart';
import 'package:intl/intl.dart';
import 'package:musliemapp/features/prayer_times/presentation/controllers/prayer_times_controller.dart';

/// مزامنة ويدجتات الشاشة الرئيسية (Android): مواقيت الصلاة + بطاقة التاريخ/التقويم فقط.
/// لا يُحدَّث العد التنازلي ولا توجد مزامنة دورية — التحديث عند تحميل المواقيت من التطبيق.
class HomeWidgetSyncService {
  HomeWidgetSyncService._();

  static const String _calendarQualified =
      'com.alssqr.musliemapp.CalendarWidgetProvider';
  static const String _timesQualified =
      'com.alssqr.musliemapp.PrayerTimesWidgetProvider';

  static bool get _isAndroid =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

  static Future<void> syncPrayerData(PrayerTimesController c) async {
    if (!_isAndroid) return;
    try {
      final h = c.hijriDate.value;
      final gregorianLine =
          DateFormat('d MMMM yyyy', 'ar').format(c.georgianDate.value);
      final moonLine = '${c.moonPhase.value} ${c.moonPhaseName.value}';
      final ramadanLine = c.daysToRamadan.value > 0
          ? 'متبقي على رمضان: ${c.daysToRamadan.value} يوماً'
          : '';

      await Future.wait([
        HomeWidget.saveWidgetData<String>('wn_loc', c.locationSource.value),
        HomeWidget.saveWidgetData<String>('cal_hijri_day', '${h.hDay}'),
        HomeWidget.saveWidgetData<String>(
          'cal_hijri_month',
          c.arabicHijriMonth.value,
        ),
        HomeWidget.saveWidgetData<String>('cal_hijri_year', '${h.hYear} هـ'),
        HomeWidget.saveWidgetData<String>('cal_greg', gregorianLine),
        HomeWidget.saveWidgetData<String>('cal_moon', moonLine),
        HomeWidget.saveWidgetData<String>('cal_ramadan', ramadanLine),
        HomeWidget.saveWidgetData<String>('wt_fajr', c.fajrTime.value),
        HomeWidget.saveWidgetData<String>('wt_sunrise', c.sunriseTime.value),
        HomeWidget.saveWidgetData<String>('wt_dhuhr', c.dhuhrTime.value),
        HomeWidget.saveWidgetData<String>('wt_asr', c.asrTime.value),
        HomeWidget.saveWidgetData<String>('wt_maghrib', c.maghribTime.value),
        HomeWidget.saveWidgetData<String>('wt_isha', c.ishaTime.value),
      ]);

      await HomeWidget.updateWidget(qualifiedAndroidName: _calendarQualified);
      await HomeWidget.updateWidget(qualifiedAndroidName: _timesQualified);
    } catch (e, st) {
      debugPrint('HomeWidgetSyncService: $e\n$st');
    }
  }
}
