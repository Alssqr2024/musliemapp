import 'package:flutter/foundation.dart';

/// Centralized logging service for the app
/// Replaces print() statements with proper logging
class LoggerService {
  static const String _appName = 'MusliemApp';

  /// Log debug messages (only in debug mode)
  static void debug(String message, [String? tag]) {
    if (kDebugMode) {
      final tagStr = tag != null ? '[$tag]' : '';
      debugPrint('$_appName DEBUG $tagStr: $message');
    }
  }

  /// Log info messages
  static void info(String message, [String? tag]) {
    if (kDebugMode) {
      final tagStr = tag != null ? '[$tag]' : '';
      debugPrint('$_appName INFO $tagStr: $message');
    }
  }

  /// Log warning messages
  static void warning(String message, [String? tag]) {
    if (kDebugMode) {
      final tagStr = tag != null ? '[$tag]' : '';
      debugPrint('$_appName WARNING $tagStr: $message');
    }
  }

  /// Log error messages
  static void error(String message, [Object? error, StackTrace? stackTrace, String? tag]) {
    final tagStr = tag != null ? '[$tag]' : '';
    debugPrint('$_appName ERROR $tagStr: $message');
    if (error != null) {
      debugPrint('Error details: $error');
    }
    if (stackTrace != null && kDebugMode) {
      debugPrint('Stack trace: $stackTrace');
    }
  }
}
