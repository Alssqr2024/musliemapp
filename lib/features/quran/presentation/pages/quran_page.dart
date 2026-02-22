import 'package:flutter/material.dart';
import 'package:musliemapp/core/theme/app_theme.dart';
import 'package:quran_library/quran_library.dart';

class QuranPage extends StatelessWidget {
  const QuranPage({super.key});

  @override
  Widget build(BuildContext context) {
    return QuranLibraryScreen(
      parentContext: context,
      withPageView: true,
      useDefaultAppBar: true,
      showAyahBookmarkedIcon: true,
      isDark: true,
      appLanguageCode: 'ar',
      backgroundColor: AppTheme.backgroundColor,
      textColor: AppTheme.textPrimary,
      ayahSelectedBackgroundColor: AppTheme.primaryColor.withValues(alpha: 0.2),
      ayahIconColor: AppTheme.primaryColor,
    );
  }
}
