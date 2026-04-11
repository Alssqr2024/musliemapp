import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:musliemapp/core/services/logger_service.dart';

List<dynamic> _decodeList(String jsonString) {
  final decoded = jsonDecode(jsonString);
  if (decoded is! List) return [];
  return decoded;
}

Map<String, dynamic> _decodeMap(String jsonString) {
  final decoded = jsonDecode(jsonString);
  if (decoded is! Map<String, dynamic>) return {};
  return decoded;
}

/// تحميل JSON من الـ assets بشكل آمن مع معالجة الأخطاء وتسجيلها مسنداً إلى Isolate
class JsonLoader {
  JsonLoader._();

  /// يحمل ملف JSON ويعيده كـ List. يتم تحليل البيانات في مسار خلفي (Isolate).
  static Future<List<dynamic>> loadList(String assetPath) async {
    try {
      final String raw = await rootBundle.loadString(assetPath);
      return await compute(_decodeList, raw);
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

  /// يحمل ملف JSON ويعيده كـ Map. يتم تحليل البيانات في مسار خلفي (Isolate).
  static Future<Map<String, dynamic>> loadMap(String assetPath) async {
    try {
      final String raw = await rootBundle.loadString(assetPath);
      return await compute(_decodeMap, raw);
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
