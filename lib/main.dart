import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:musliemapp/core/theme/app_theme.dart';
import 'package:musliemapp/home_page.dart';
import 'package:quran_library/quran_library.dart';
import 'package:musliemapp/core/services/notification_service.dart';
import 'package:musliemapp/core/bindings/app_bindings.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ar', null);
  await NotificationService().init();
  await QuranLibrary.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialBinding: AppBindings(),
      home: Directionality(textDirection: TextDirection.rtl, child: HomePage()),
      locale: const Locale('ar', 'SA'),
      fallbackLocale: const Locale('ar', 'SA'),
    );
  }
}
