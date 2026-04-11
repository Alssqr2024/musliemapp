/// Keys for [SharedPreferences] — keep in sync with [SettingsController].
abstract final class AppSettingsKeys {
  static const String notifyPrayer = 'settings_notify_prayer';
  static const String notifyQuranDaily = 'settings_notify_quran_daily';
  /// `online` = GPS + reverse geocode, `manual` = saved coordinates only.
  static const String locationMode = 'settings_location_mode';
  static const String manualLat = 'settings_manual_lat';
  static const String manualLon = 'settings_manual_lon';
  static const String manualLabel = 'settings_manual_label';
  static const String quranReminderHour = 'settings_quran_hour';
  static const String quranReminderMinute = 'settings_quran_minute';

  static const String locationModeOnline = 'online';
  static const String locationModeManual = 'manual';
}
