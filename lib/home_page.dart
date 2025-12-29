import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musliemapp/core/theme/app_theme.dart';
import 'package:musliemapp/features/azkar/presentation/pages/azkar_page.dart';
import 'package:musliemapp/features/names_of_allah/presentation/pages/names_allah_page.dart';
import 'package:musliemapp/features/hadith/presentation/pages/nawawi_page.dart';
import 'package:musliemapp/features/hadith/presentation/pages/qudsi_page.dart';
import 'package:musliemapp/features/hadith/presentation/pages/shamail_page.dart';
import 'package:musliemapp/utils/widgets/card_home.dart';
import 'package:musliemapp/features/stories/presentation/pages/stories_menu_page.dart';
import 'package:musliemapp/features/prayer/presentation/pages/prayer_page.dart';
import 'package:musliemapp/features/ramadan/presentation/pages/ramadan_page.dart';
import 'package:musliemapp/features/another/presentation/pages/another_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            backgroundColor: AppTheme.primaryColor,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: const Text(
                '🕋أذكار المسلم',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppTheme.primaryColor,
                      AppTheme.primaryColor.withOpacity(0.8),
                    ],
                  ),
                ),
                child: Center(
                  child: Opacity(
                    opacity: 0.1,
                    child: Icon(Icons.mosque, size: 150, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.85,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              delegate: SliverChildListDelegate([
                CardHome(
                  icon: Icons.menu_book_rounded,
                  title: 'القصص الإسلامية',
                  onClick: () {
                    Get.to(
                      () => const StoriesMenuPage(),
                      transition: Transition.fadeIn,
                    );
                  },
                ),
                CardHome(
                  icon: Icons.volunteer_activism_rounded,
                  title: 'أدعية',
                  onClick: () {
                    Get.to(
                      () => const PrayerPage(),
                      transition: Transition.fadeIn,
                    );
                  },
                ),
                CardHome(
                  icon: Icons.calendar_month_rounded,
                  title: 'رمضان المبارك',
                  onClick: () {
                    Get.to(
                      () => const RamadanPage(),
                      transition: Transition.fadeIn,
                    );
                  },
                ),
                CardHome(
                  icon: Icons.library_books_rounded,
                  title: 'منوعات إسلامية',
                  onClick: () {
                    Get.to(
                      () => const AnotherPage(),
                      transition: Transition.fadeIn,
                    );
                  },
                ),
                CardHome(
                  icon: Icons.library_books_rounded,
                  title: 'الاربعون النووية',
                  onClick: () {
                    Get.to(() => NawawiPage(), transition: Transition.fadeIn);
                  },
                ),
                CardHome(
                  icon: Icons.stars_rounded,
                  title: 'أسماء الله الحسنى',
                  onClick: () {
                    Get.to(
                      () => const NamesAllahPage(),
                      transition: Transition.fadeIn,
                    );
                  },
                ),
                CardHome(
                  icon: Icons.auto_stories_rounded,
                  title: 'شمائل محمدية',
                  onClick: () {
                    Get.to(() => ShamailPage(), transition: Transition.fadeIn);
                  },
                ),
                CardHome(
                  icon: Icons.security_rounded,
                  title: 'حصن المسلم',
                  onClick: () {
                    Get.to(() => AzkarPage(), transition: Transition.fadeIn);
                  },
                ),
                CardHome(
                  icon: Icons.format_quote_rounded,
                  title: 'الحديث القدسي',
                  onClick: () {
                    Get.to(() => QudsiPage(), transition: Transition.fadeIn);
                  },
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
