import 'package:flutter/material.dart';
import 'package:musliemapp/utils/constants/constants.dart';

class AppTheme {
  // Colors - Royal Emerald Glass Palette
  static const Color primaryColor = Color(0xFF0F5132); // Deep Emerald
  static const Color secondaryColor = Color(0xFFFFD700); // Gold
  static const Color accentColor = Color(0xFF198754);
  static const Color backgroundColor = Color(0xFF0F2027); // Dark Background
  static const Color surfaceColor = Color(0xFF1E3A43); // Dark Surface

  static const Color textPrimary = Color(0xFFF8F9FA); // Light Text
  static const Color textSecondary = Color(0xFFADB5BD); // Muted Text

  // Gradients
  static const LinearGradient mainGradient = LinearGradient(
    colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Colors.white10, Colors.white24],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// خلفية موحّدة لبطاقات الشبكة (أسماء الله وما شابه) — ألوان التطبيق فقط
  static const LinearGradient unifiedGridCardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [surfaceColor, Color(0xFF152A32)],
  );

  // Text Styles
  static const TextStyle heading1 = TextStyle(
    fontFamily: Constants.fontTajawal,
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: textPrimary,
  );

  static const TextStyle heading2 = TextStyle(
    fontFamily: Constants.fontTajawal,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: textPrimary,
  );

  static const TextStyle bodyText = TextStyle(
    fontFamily: Constants.fontTajawal,
    fontSize: 16,
    color: textPrimary,
    height: 1.5,
  );

  // Theme Data
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,

      fontFamily: Constants.fontTajawal,
      textTheme: const TextTheme().apply(
        fontFamily: Constants.fontTajawal,
        bodyColor: textPrimary,
        displayColor: textPrimary,
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleTextStyle: TextStyle(
          fontFamily: Constants.fontTajawal,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),

      cardTheme: CardThemeData(
        color: Colors.white.withValues(alpha: 0.05),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
        ),
      ),

      colorScheme: ColorScheme.dark(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: surfaceColor,
        error: Colors.redAccent,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: secondaryColor,
          foregroundColor: primaryColor,
          textStyle: const TextStyle(
            fontFamily: Constants.fontTajawal,
            fontWeight: FontWeight.bold,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
