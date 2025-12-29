import 'package:flutter/material.dart';
import 'package:musliemapp/utils/constants/constants.dart';

class AppTheme {
  // Colors
  static const Color primaryColor = Color(0xFF0F5132); // Deep Emerald Green
  static const Color secondaryColor = Color(0xFFD4AF37); // Metallic Gold
  static const Color accentColor = Color(
    0xFF198754,
  ); // Lighter Green for accents
  static const Color backgroundColor = Color(0xFFF8F9FA); // Soft White/Grey
  static const Color surfaceColor = Colors.white;
  static const Color errorColor = Color(0xFFDC3545);

  static const Color textPrimary = Color(0xFF212529);
  static const Color textSecondary = Color(0xFF6C757D);

  // Text Styles
  static const TextStyle heading1 = TextStyle(
    fontFamily: Constants.fontTajawal,
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: textPrimary,
  );

  static const TextStyle heading2 = TextStyle(
    fontFamily: Constants.fontTajawal,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: textPrimary,
  );

  static const TextStyle bodyText = TextStyle(
    fontFamily: Constants.fontTajawal,
    fontSize: 16,
    color: textPrimary,
    height: 1.5,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: Constants.fontTajawal,
    fontSize: 14,
    color: textSecondary,
  );

  // Theme Data
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      fontFamily: Constants.fontTajawal,

      appBarTheme: const AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleTextStyle: TextStyle(
          fontFamily: Constants.fontTajawal,
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),

      cardTheme: CardThemeData(
        color: surfaceColor,
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      ),

      iconTheme: const IconThemeData(color: primaryColor),

      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: surfaceColor,
        background: backgroundColor,
        error: errorColor,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          textStyle: const TextStyle(
            fontFamily: Constants.fontTajawal,
            fontWeight: FontWeight.bold,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
    );
  }
}
