import 'package:adhan/adhan.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:flutter/foundation.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  /// Prayer slots use `dayOffset * 10 + (prayerIndex + 1)` → max 65 for 7 days × 5 prayers.
  static const int _prayerNotificationIdMin = 1;
  static const int _prayerNotificationIdMax = 70;
  static const int quranDailyNotificationId = 200;
  static const int _testShowId = 901;
  static const int _testScheduleId = 902;
  static const int _daysToSchedulePrayers = 7;

  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    // 1. Initialize Timezones
    tz.initializeTimeZones();
    String timeZoneName = 'UTC'; // Default fallback
    try {
      timeZoneName = await FlutterTimezone.getLocalTimezone();
    } catch (e) {
      // Falls back to UTC if the plugin isn't available
      // This can happen on first run before a full rebuild
    }
    tz.setLocalLocation(tz.getLocation(timeZoneName));

    // 2. Android Settings
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // 3. Initialization Settings
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    // 4. Initialize Plugin
    await _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        // Handle notification click if needed
      },
    );

    // 5. Request Permissions for Android 13+
    final androidPlugin = _notificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    if (androidPlugin != null) {
      await androidPlugin.requestNotificationsPermission();
      await androidPlugin.requestExactAlarmsPermission();

      // 6. Explicitly create the notification channel (required for Android 8+)
      // This ensures the channel exists with the correct settings even in release builds.
      await androidPlugin.createNotificationChannel(
        const AndroidNotificationChannel(
          'prayer_times_channel',
          'مواقيت الصلاة',
          description: 'تنبيهات عند دخول وقت الصلاة',
          importance: Importance.max,
          playSound: true,
          sound: RawResourceAndroidNotificationSound('prayer_alert'),
          enableVibration: true,
        ),
      );
      await androidPlugin.createNotificationChannel(
        const AndroidNotificationChannel(
          'quran_daily_channel',
          'الورد اليومي من القرآن',
          description: 'تذكير يومي لقراءة القرآن الكريم',
          importance: Importance.high,
          playSound: true,
          enableVibration: true,
        ),
      );
    }
  }

  Future<void> cancelPrayerNotifications() async {
    for (int id = _prayerNotificationIdMin; id <= _prayerNotificationIdMax; id++) {
      await _notificationsPlugin.cancel(id);
    }
  }

  Future<void> cancelQuranDailyNotification() async {
    await _notificationsPlugin.cancel(quranDailyNotificationId);
  }

  /// Schedules the five daily prayers for the next [_daysToSchedulePrayers] days.
  Future<void> schedulePrayerWeek(Coordinates coordinates) async {
    final params = CalculationMethod.muslim_world_league.getParameters();
    params.madhab = Madhab.shafi;
    const prayerNames = ['الفجر', 'الظهر', 'العصر', 'المغرب', 'العشاء'];

    for (int dayOffset = 0; dayOffset < _daysToSchedulePrayers; dayOffset++) {
      final date = DateTime.now().add(Duration(days: dayOffset));
      final dateComponents = DateComponents.from(date);
      final dayPrayerTimes = PrayerTimes(coordinates, dateComponents, params);
      final times = [
        dayPrayerTimes.fajr,
        dayPrayerTimes.dhuhr,
        dayPrayerTimes.asr,
        dayPrayerTimes.maghrib,
        dayPrayerTimes.isha,
      ];
      for (int i = 0; i < 5; i++) {
        final id = dayOffset * 10 + (i + 1);
        await schedulePrayerNotification(
          id: id,
          title: 'حان الآن موعد صلاة ${prayerNames[i]}',
          body: 'أقم صلاتك يا رعاك الله',
          scheduledDate: times[i],
        );
      }
    }
  }

  /// Repeats every day at [hour]:[minute] in the device local timezone.
  Future<void> scheduleDailyQuranReminder({
    required int hour,
    required int minute,
  }) async {
    await cancelQuranDailyNotification();

    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }

    await _notificationsPlugin.zonedSchedule(
      quranDailyNotificationId,
      'وقت الورد اليومي من القرآن',
      'اقرأ القرآن ولو آية، بارك الله فيك',
      scheduled,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'quran_daily_channel',
          'الورد اليومي من القرآن',
          channelDescription: 'تذكير يومي لقراءة القرآن الكريم',
          importance: Importance.high,
          priority: Priority.high,
          playSound: true,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> requestBatteryOptimizationExemption() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      try {
        const intent = AndroidIntent(
          action: 'android.settings.IGNORE_BATTERY_OPTIMIZATION_SETTINGS',
          flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
        );
        await intent.launch();
      } catch (e) {
        debugPrint('Failed to open battery optimization settings: $e');
      }
    }
  }

  Future<void> schedulePrayerNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
  }) async {
    final tz.TZDateTime tzScheduledDate = tz.TZDateTime.from(
      scheduledDate,
      tz.local,
    );

    // If the time is in the past, don't schedule
    if (tzScheduledDate.isBefore(tz.TZDateTime.now(tz.local))) return;

    await _notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tzScheduledDate,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'prayer_times_channel',
          'مواقيت الصلاة',
          channelDescription: 'تنبيهات عند دخول وقت الصلاة',
          importance: Importance.max,
          priority: Priority.high,
          sound: RawResourceAndroidNotificationSound('prayer_alert'),
          playSound: true,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  /// Sends an immediate test notification to verify the system works.
  Future<void> sendTestNotification() async {
    await _notificationsPlugin.show(
      _testShowId,
      '🕌 اختبار إشعار الصلاة',
      'هذا إشعار تجريبي فوري - النظام يعمل بشكل صحيح ✅',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'prayer_times_channel',
          'مواقيت الصلاة',
          channelDescription: 'تنبيهات عند دخول وقت الصلاة',
          importance: Importance.max,
          priority: Priority.high,
          sound: RawResourceAndroidNotificationSound('prayer_alert'),
          playSound: true,
        ),
      ),
    );
  }

  /// Schedules a test notification to verify background alarm manager works.
  Future<void> scheduleTestNotification({int seconds = 30}) async {
    final tz.TZDateTime tzScheduledDate = tz.TZDateTime.now(tz.local).add(
      Duration(seconds: seconds),
    );

    await _notificationsPlugin.zonedSchedule(
      _testScheduleId,
      '🕌 اختبار إشعار الخلفية',
      'نجاح! التطبيق قادر على إرسال الأذان حتى وهو مغلق ✅',
      tzScheduledDate,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'prayer_times_channel',
          'مواقيت الصلاة',
          channelDescription: 'تنبيهات عند دخول وقت الصلاة',
          importance: Importance.max,
          priority: Priority.high,
          sound: RawResourceAndroidNotificationSound('prayer_alert'),
          playSound: true,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> cancelAllNotifications() async {
    await _notificationsPlugin.cancelAll();
  }
}
