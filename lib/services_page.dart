import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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
import 'package:musliemapp/features/quran/presentation/pages/quran_page.dart';
import 'package:musliemapp/features/prayer_times/presentation/pages/prayer_times_page.dart';
import 'package:musliemapp/features/qibla/presentation/pages/qibla_page.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'الخدمات الإسلامية',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'Tajawal',
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: const BoxDecoration(gradient: AppTheme.mainGradient),
          ),

          // Background Decorations
          Positioned(
            bottom: -50,
            left: -50,
            child: Opacity(
              opacity: 0.05,
              child: Icon(Icons.mosque, size: 300, color: Colors.white),
            ),
          ),

          SafeArea(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverToBoxAdapter(
                    child: StaggeredGrid.count(
                      crossAxisCount: 4,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      children: [
                        // Quran - Big Feature
                        StaggeredGridTile.count(
                          crossAxisCellCount: 4,
                          mainAxisCellCount: 2,
                          child: _buildServiceCard(
                            Icons.menu_book,
                            'القرآن الكريم',
                            () => const QuranPage(),
                            type: CardType.wide,
                            subtitle: 'قراءة، استماع وتفسير',
                          ),
                        ),

                        // Prayer Times
                        StaggeredGridTile.count(
                          crossAxisCellCount: 2,
                          mainAxisCellCount: 2,
                          child: _buildServiceCard(
                            Icons.access_time_rounded,
                            'مواقيت الصلاة',
                            () => const PrayerTimesPage(),
                          ),
                        ),

                        // Qibla
                        StaggeredGridTile.count(
                          crossAxisCellCount: 2,
                          mainAxisCellCount: 2,
                          child: _buildServiceCard(
                            Icons.explore_rounded,
                            'اتجاه القبلة',
                            () => const QiblaPage(),
                          ),
                        ),

                        // Azkar
                        StaggeredGridTile.count(
                          crossAxisCellCount: 2,
                          mainAxisCellCount: 2,
                          child: _buildServiceCard(
                            Icons.security_rounded,
                            'حصن المسلم',
                            () => AzkarPage(),
                          ),
                        ),

                        // Names of Allah
                        StaggeredGridTile.count(
                          crossAxisCellCount: 2,
                          mainAxisCellCount: 2,
                          child: _buildServiceCard(
                            Icons.stars_rounded,
                            'أسماء الله الحسنى',
                            () => const NamesAllahPage(),
                          ),
                        ),

                        // Stories
                        StaggeredGridTile.count(
                          crossAxisCellCount: 4,
                          mainAxisCellCount: 1.5,
                          child: _buildServiceCard(
                            Icons.menu_book_rounded,
                            'القصص الإسلامية',
                            () => const StoriesMenuPage(),
                            type: CardType.wide,
                          ),
                        ),

                        // Ramadan
                        StaggeredGridTile.count(
                          crossAxisCellCount: 2,
                          mainAxisCellCount: 2,
                          child: _buildServiceCard(
                            Icons.calendar_month_rounded,
                            'رمضان المبارك',
                            () => const RamadanPage(),
                          ),
                        ),

                        // Duas
                        StaggeredGridTile.count(
                          crossAxisCellCount: 2,
                          mainAxisCellCount: 2,
                          child: _buildServiceCard(
                            Icons.volunteer_activism_rounded,
                            'أدعية مستجابة',
                            () => const PrayerPage(),
                          ),
                        ),

                        // Hadith Sections
                        StaggeredGridTile.count(
                          crossAxisCellCount: 2,
                          mainAxisCellCount: 1,
                          child: _buildServiceCard(
                            Icons.format_list_numbered_rounded,
                            'الأربعون',
                            () => NawawiPage(),
                            type: CardType.wide,
                          ),
                        ),
                        StaggeredGridTile.count(
                          crossAxisCellCount: 2,
                          mainAxisCellCount: 1,
                          child: _buildServiceCard(
                            Icons.auto_stories_rounded,
                            'الشمائل',
                            () => ShamailPage(),
                            type: CardType.wide,
                          ),
                        ),
                        StaggeredGridTile.count(
                          crossAxisCellCount: 4,
                          mainAxisCellCount: 1.5,
                          child: _buildServiceCard(
                            Icons.format_quote_rounded,
                            'الحديث القدسي',
                            () => QudsiPage(),
                            type: CardType.wide,
                          ),
                        ),

                        // Miscellaneous
                        StaggeredGridTile.count(
                          crossAxisCellCount: 4,
                          mainAxisCellCount: 1.5,
                          child: _buildServiceCard(
                            Icons.category_rounded,
                            'منوعات إسلامية',
                            () => const AnotherPage(),
                            type: CardType.wide,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(
    IconData icon,
    String title,
    Widget Function() page, {
    CardType type = CardType.square,
    String? subtitle,
  }) {
    return CardHome(
      icon: icon,
      title: title,
      type: type,
      subtitle: subtitle,
      onClick: () {
        Get.to(
          page,
          transition: Transition.cupertino,
          duration: const Duration(milliseconds: 500),
        );
      },
    );
  }
}
