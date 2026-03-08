import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:musliemapp/core/services/logger_service.dart';

/// تحميل JSON من الـ assets بشكل آمن مع معالجة الأخطاء وتسجيلها
class JsonLoader {
  JsonLoader._();

  /// يحمل ملف JSON ويعيده كـ List. عند الفشل يرجع قائمة فارغة ويسجل الخطأ.
  static Future<List<dynamic>> loadList(String assetPath) async {
    try {
      final String raw = await rootBundle.loadString(assetPath);
      final decoded = jsonDecode(raw);
      if (decoded is! List) return [];
      return decoded;
    } catch (e, st) {
      LoggerService.error(
        'JsonLoader.loadList failed: $assetPath',
        e,
        st,
        'JsonLoader',
      );
      return [];
    }
  }

  /// يحمل ملف JSON ويعيده كـ Map. عند الفشل يرجع خريطة فارغة ويسجل الخطأ.
  static Future<Map<String, dynamic>> loadMap(String assetPath) async {
    try {
      final String raw = await rootBundle.loadString(assetPath);
      final decoded = jsonDecode(raw);
      if (decoded is! Map<String, dynamic>) return {};
      return decoded;
    } catch (e, st) {
      LoggerService.error(
        'JsonLoader.loadMap failed: $assetPath',
        e,
        st,
        'JsonLoader',
      );
      return {};
    }
  }
}
