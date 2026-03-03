import 'dart:async';
import 'package:adhan/adhan.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hijri/hijri_calendar.dart';
import 'package:flutter/material.dart';
import 'package:musliemapp/core/services/notification_service.dart';
import 'package:musliemapp/core/services/logger_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrayerTimesController extends GetxController {
  final RxBool isLoading = true.obs;
  final RxString errorMessage = ''.obs;
  final RxString locationSource = 'تلقائي'.obs;

  final RxString fajrTime = '--:--'.obs;
  final RxString sunriseTime = '--:--'.obs;
  final RxString dhuhrTime = '--:--'.obs;
  final RxString asrTime = '--:--'.obs;
  final RxString maghribTime = '--:--'.obs;
  final RxString ishaTime = '--:--'.obs;

  final RxString nextPrayerName = ''.obs;
  final RxString nextPrayerTime = ''.obs;
  final RxInt remainingSeconds = 0.obs;
  final RxInt daysToRamadan = 0.obs;
  final RxString moonPhase = '🌑'.obs;
  final RxString dayDhikr =
      'سبحان الله والحمد لله ولا إله إلا الله والله أكبر'.obs;
  final RxString dayHadith =
      'قال رسول الله ﷺ: «لأن أقول: سبحان الله والحمد لله ولا إله إلا الله والله أكبر؛ أحب إليّ مما طلعت عليه الشمس»'
          .obs;
  final RxString hadithNarrator = 'أخرجه مسلم (2695)'.obs;
  final Rx<HijriCalendar> hijriDate = HijriCalendar.now().obs;
  final Rx<DateTime> georgianDate = DateTime.now().obs;
  final RxString arabicHijriMonth = ''.obs;
  final Rx<IconData> moonPhaseIcon = Icons.brightness_3_rounded.obs;
  final RxString moonPhaseName = 'محاق'.obs;

  PrayerTimes? _prayerTimes;
  Coordinates? _lastCoordinates;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    _calculateCalendarExtras();
    loadPrayerTimes();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  String _formatTime(DateTime dt) {
    try {
      return DateFormat('hh:mm a', 'ar').format(dt);
    } catch (e) {
      return DateFormat('hh:mm a').format(dt); // Fallback to default locale
    }
  }

  Future<void> loadPrayerTimes() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      Position? position;
      try {
        position = await _determinePosition();
        // Reverse geocode using OpenStreetMap Nominatim (no API key needed)
        try {
          final url = Uri.parse(
            'https://nominatim.openstreetmap.org/reverse'
            '?lat=${position.latitude}&lon=${position.longitude}'
            '&format=json&accept-language=ar',
          );
          final resp = await http
              .get(url, headers: {'User-Agent': 'MusliemApp/1.0'})
              .timeout(const Duration(seconds: 5));
          if (resp.statusCode == 200) {
            final data = jsonDecode(resp.body);
            final address = data['address'] as Map<String, dynamic>;
            final city =
                address['city'] ??
                address['town'] ??
                address['village'] ??
                address['county'] ??
                address['state'] ??
                'موقعك';
            locationSource.value = city.toString();
          } else {
            locationSource.value = 'تلقائي';
          }
        } catch (_) {
          locationSource.value = 'تلقائي';
        }
      } catch (locError) {
        // Fallback to Mecca if GPS fails
        LoggerService.warning('Location detection failed, using Mecca as fallback', 'PrayerTimes');
        errorMessage.value =
            'تعذّر تحديد الموقع تلقائياً. تم استخدام توقيت مكة المكرمة كافتراضي. يرجى التأكد من الـ GPS.';
        position = Position(
          latitude: 21.4225,
          longitude: 39.8262,
          timestamp: DateTime.now(),
          accuracy: 0,
          altitude: 0,
          heading: 0,
          speed: 0,
          speedAccuracy: 0,
          altitudeAccuracy: 0,
          headingAccuracy: 0,
        );
        locationSource.value = 'مكة المكرمة (افتراضي)';
      }

      _lastCoordinates = Coordinates(position.latitude, position.longitude);
      _saveCoordinatesForReschedule(position.latitude, position.longitude);
      final params = CalculationMethod.muslim_world_league.getParameters();
      params.madhab = Madhab.shafi;

      _prayerTimes = PrayerTimes.today(_lastCoordinates!, params);

      fajrTime.value = _formatTime(_prayerTimes!.fajr);
      sunriseTime.value = _formatTime(_prayerTimes!.sunrise);
      dhuhrTime.value = _formatTime(_prayerTimes!.dhuhr);
      asrTime.value = _formatTime(_prayerTimes!.asr);
      maghribTime.value = _formatTime(_prayerTimes!.maghrib);
      ishaTime.value = _formatTime(_prayerTimes!.isha);

      _updateNextPrayer();

      // Only reschedule if it's a new day or prayer times changed significantly
      if (_needsReschedule()) {
        _scheduleNotifications();
      }

      _startTimer();
    } catch (e) {
      LoggerService.error('Error loading prayer times', e, StackTrace.current, 'PrayerTimes');
      errorMessage.value = 'حدث خطأ غير متوقع. يرجى المحاولة مرة أخرى.';
    } finally {
      isLoading.value = false;
    }
  }

  DateTime? _lastScheduledDay;
  bool _needsReschedule() {
    final now = DateTime.now();
    if (_lastScheduledDay == null) return true;
    final daysSinceScheduled = now.difference(_lastScheduledDay!).inDays;
    return daysSinceScheduled >= _daysToSchedule - 1;
  }

  static const int _daysToSchedule = 7;
  static const String _keyLat = 'prayer_last_lat';
  static const String _keyLon = 'prayer_last_lon';

  Future<void> _saveCoordinatesForReschedule(double lat, double lon) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble(_keyLat, lat);
      await prefs.setDouble(_keyLon, lon);
    } catch (_) {}
  }

  void _scheduleNotifications() {
    if (_prayerTimes == null || _lastCoordinates == null) return;

    final notificationService = NotificationService();
    notificationService.cancelAllNotifications();

    final params = CalculationMethod.muslim_world_league.getParameters();
    params.madhab = Madhab.shafi;
    const prayerNames = ['الفجر', 'الظهر', 'العصر', 'المغرب', 'العشاء'];

    for (int dayOffset = 0; dayOffset < _daysToSchedule; dayOffset++) {
      final date = DateTime.now().add(Duration(days: dayOffset));
      final dateComponents = DateComponents.from(date);
      final dayPrayerTimes = PrayerTimes(_lastCoordinates!, dateComponents, params);
      final times = [
        dayPrayerTimes.fajr,
        dayPrayerTimes.dhuhr,
        dayPrayerTimes.asr,
        dayPrayerTimes.maghrib,
        dayPrayerTimes.isha,
      ];
      for (int i = 0; i < 5; i++) {
        final id = dayOffset * 10 + (i + 1);
        notificationService.schedulePrayerNotification(
          id: id,
          title: 'حان الآن موعد صلاة ${prayerNames[i]}',
          body: 'أقم صلاتك يا رعاك الله',
          scheduledDate: times[i],
        );
      }
    }
    _lastScheduledDay = DateTime.now();
  }

  void _updateNextPrayer() {
    if (_prayerTimes == null) return;
    final now = DateTime.now();
    final prayers = [
      {'name': 'الفجر', 'time': _prayerTimes!.fajr},
      {'name': 'الشروق', 'time': _prayerTimes!.sunrise},
      {'name': 'الظهر', 'time': _prayerTimes!.dhuhr},
      {'name': 'العصر', 'time': _prayerTimes!.asr},
      {'name': 'المغرب', 'time': _prayerTimes!.maghrib},
      {'name': 'العشاء', 'time': _prayerTimes!.isha},
    ];

    Map<String, dynamic>? next;
    for (final p in prayers) {
      if ((p['time'] as DateTime).isAfter(now)) {
        next = p;
        break;
      }
    }
    if (next != null) {
      nextPrayerName.value = next['name'] as String;
      nextPrayerTime.value = _formatTime(next['time'] as DateTime);
      remainingSeconds.value = (next['time'] as DateTime)
          .difference(now)
          .inSeconds;
    } else {
      // All prayers for today are done — calculate tomorrow's Fajr
      final tomorrow = DateComponents.from(now.add(const Duration(days: 1)));
      try {
        final params = CalculationMethod.muslim_world_league.getParameters();
        params.madhab = Madhab.shafi;
        final tomorrowPrayers = PrayerTimes(
          _lastCoordinates ?? Coordinates(21.4225, 39.8262),
          tomorrow,
          params,
        );
        final tomorrowFajr = tomorrowPrayers.fajr;
        nextPrayerName.value = 'الفجر (غداً)';
        nextPrayerTime.value = _formatTime(tomorrowFajr);
        remainingSeconds.value = tomorrowFajr.difference(now).inSeconds;
      } catch (_) {
        nextPrayerName.value = 'الفجر (غداً)';
        nextPrayerTime.value = fajrTime.value;
        remainingSeconds.value = 0;
      }
    }
  }

  void _startTimer() {
    _timer?.cancel(); // Cancel any existing timer
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
      } else {
        _updateNextPrayer();
      }
    });
  }

  String get remainingFormatted {
    final h = remainingSeconds.value ~/ 3600;
    final m = (remainingSeconds.value % 3600) ~/ 60;
    final s = remainingSeconds.value % 60;
    return '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('GPS disabled');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Permission denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      throw Exception('Permission denied forever');
    }

    // Attempt to get last known position first
    Position? position = await Geolocator.getLastKnownPosition();
    if (position != null) return position;

    // Use a more aggressive approach for Android if Play Services is problematic
    return await Geolocator.getCurrentPosition(
      locationSettings: AndroidSettings(
        accuracy: LocationAccuracy.medium,
        timeLimit: const Duration(seconds: 10),
        forceLocationManager: true, // Use standard Android location manager
      ),
    );
  }

  void _calculateCalendarExtras() {
    final hijri = HijriCalendar.now();

    hijriDate.value = hijri;
    georgianDate.value = DateTime.now();

    // Moon Phase logic based on Hijri day
    final day = hijri.hDay;
    if (day <= 2) {
      moonPhase.value = '🌑';
      moonPhaseIcon.value = Icons.brightness_3_rounded;
      moonPhaseName.value = 'محاق';
    } else if (day <= 7) {
      moonPhase.value = '🌒';
      moonPhaseIcon.value = Icons.brightness_4_rounded;
      moonPhaseName.value = 'هلال';
    } else if (day <= 10) {
      moonPhase.value = '🌓';
      moonPhaseIcon.value = Icons.brightness_2_rounded;
      moonPhaseName.value = 'تربيع أول';
    } else if (day <= 13) {
      moonPhase.value = '🌔';
      moonPhaseIcon.value = Icons.brightness_5_rounded;
      moonPhaseName.value = 'أحدب متزايد';
    } else if (day <= 16) {
      moonPhase.value = '🌕';
      moonPhaseIcon.value = Icons.brightness_high_rounded;
      moonPhaseName.value = 'بدر';
    } else if (day <= 20) {
      moonPhase.value = '🌖';
      moonPhaseIcon.value = Icons.brightness_6_rounded;
      moonPhaseName.value = 'أحدب متناقص';
    } else if (day <= 24) {
      moonPhase.value = '🌗';
      moonPhaseIcon.value = Icons.brightness_4_rounded;
      moonPhaseName.value = 'تربيع ثاني';
    } else if (day <= 28) {
      moonPhase.value = '🌘';
      moonPhaseIcon.value = Icons.brightness_3_rounded;
      moonPhaseName.value = 'هلال ثاني';
    } else {
      moonPhase.value = '🌑';
      moonPhaseIcon.value = Icons.brightness_3_rounded;
      moonPhaseName.value = 'محاق';
    }

    // Set Arabic Month Name
    final arabicMonths = [
      'محرم',
      'صفر',
      'ربيع الأول',
      'ربيع الآخر',
      'جمادى الأولى',
      'جمادى الآخرة',
      'رجب',
      'شعبان',
      'رمضان',
      'شوال',
      'ذو القعدة',
      'ذو الحجة',
    ];
    arabicHijriMonth.value = arabicMonths[hijri.hMonth - 1];

    // Ramadan Countdown
    // Ramadan is the 9th month.
    int targetYear = hijri.hYear;
    if (hijri.hMonth > 9 || (hijri.hMonth == 9 && hijri.hDay > 1)) {
      targetYear++;
    }

    try {
      final ramadanDateTime = HijriCalendar().hijriToGregorian(
        targetYear,
        9,
        1,
      );
      final now = DateTime.now();
      final diff = ramadanDateTime
          .difference(DateTime(now.year, now.month, now.day))
          .inDays;
      daysToRamadan.value = diff < 0 ? 0 : diff;
    } catch (e) {
      daysToRamadan.value = 0;
    }

    // Daily Content Rotation
    final now = DateTime.now();
    final dayOfYear = int.parse(DateFormat('D').format(now));
    final dhikrs = [
      'سبحان الله والحمد لله ولا إله إلا الله والله أكبر',
      'سبحان الله وبحمده، سبحان الله العظيم',
      'لا إله إلا الله وحده لا شريك له، له الملك وله الحمد، وهو على كل شيء قدير',
      'لا حول ولا قوة إلا بالله العلي العظيم',
      'اللهم صلِّ وسلم على نبينا محمد',
    ];
    final hadiths = [
      {
        't':
            'قال رسول الله ﷺ: «لأن أقول: سبحان الله والحمد لله ولا إله إلا الله والله أكبر؛ أحب إليّ مما طلعت عليه الشمس»',
        'n': 'أخرجه مسلم (2695)',
      },
      {
        't':
            'قال رسول الله ﷺ: «كلمتان خفيفتان على اللسان، ثقيلتان في الميزان، حبيبتان إلى الرحمن: سبحان الله وبحمده، سبحان الله العظيم»',
        'n': 'متفق عليه',
      },
      {
        't':
            'قال رسول الله ﷺ: «من سلك طريقًا يلتمس فيه علمًا، سهّل الله له به طريقًا إلى الجنة»',
        'n': 'أخرجه مسلم',
      },
      {
        't': 'قال رسول الله ﷺ: «خيركم من تعلم القرآن وعلمه»',
        'n': 'رواه البخاري',
      },
    ];

    dayDhikr.value = dhikrs[dayOfYear % dhikrs.length];
    final h = hadiths[dayOfYear % hadiths.length];
    dayHadith.value = h['t']!;
    hadithNarrator.value = h['n']!;
  }
}
