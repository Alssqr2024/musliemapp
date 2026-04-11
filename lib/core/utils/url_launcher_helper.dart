import 'dart:io' show Platform;
import 'package:url_launcher/url_launcher.dart';
import 'package:android_intent_plus/android_intent.dart';

class UrlLauncherHelper {
  /// رقم واتساب المطور (مع رمز الدولة بدون + أو 0)
  static const String developerWhatsAppNumber = '966501436049';

  static Future<void> openWhatsApp({
    String message = 'السلام عليكم ، أتواصل بخصوص تطبيق أذكار المسلم',
  }) async {
    final String waUrl =
        'https://wa.me/$developerWhatsAppNumber?text=${Uri.encodeComponent(message)}';

    try {
      if (Platform.isAndroid) {
        final intent = AndroidIntent(
          action: 'android.intent.action.VIEW',
          data: waUrl,
          package: 'com.whatsapp',
        );
        await intent.launch();
      } else {
        await launchUrl(Uri.parse(waUrl), mode: LaunchMode.externalApplication);
      }
    } catch (_) {
      try {
        await launchUrl(Uri.parse(waUrl), mode: LaunchMode.platformDefault);
      } catch (_) {}
    }
  }
}
