import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:musliemapp/core/theme/app_theme.dart';
import 'package:musliemapp/home_page.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: Directionality(textDirection: TextDirection.rtl, child: HomePage()),
      locale: const Locale('ar', 'SA'),
      fallbackLocale: const Locale('ar', 'SA'),
    );
  }
}
