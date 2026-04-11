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

// ---------------------------------------------------------------------------
// Data model for a single service entry
// ---------------------------------------------------------------------------
class _ServiceItem {
  const _ServiceItem({
    required this.icon,
    required this.title,
    required this.page,
    this.crossAxisCellCount = 2,
    this.mainAxisCellCount = 2.0,
    this.type = CardType.square,
    this.subtitle,
  });

  final IconData icon;
  final String title;
  final Widget Function() page;
  final int crossAxisCellCount;
  final double mainAxisCellCount;
  final CardType type;
  final String? subtitle;
}

// ---------------------------------------------------------------------------
// Services list – add / remove entries here only
// ---------------------------------------------------------------------------
const List<_ServiceItem> _services = [
  _ServiceItem(
    icon: Icons.menu_book,
    title: 'القرآن الكريم',
    page: QuranPage.new,
    crossAxisCellCount: 4,
    mainAxisCellCount: 2,
    type: CardType.wide,
    subtitle: 'قراءة، استماع وتفسير',
  ),
  _ServiceItem(
    icon: Icons.access_time_rounded,
    title: 'مواقيت الصلاة',
    page: PrayerTimesPage.new,
  ),
  _ServiceItem(
    icon: Icons.explore_rounded,
    title: 'اتجاه القبلة',
    page: QiblaPage.new,
  ),
  _ServiceItem(
    icon: Icons.security_rounded,
    title: 'حصن المسلم',
    page: AzkarPage.new,
  ),
  _ServiceItem(
    icon: Icons.stars_rounded,
    title: 'أسماء الله الحسنى',
    page: NamesAllahPage.new,
  ),
  _ServiceItem(
    icon: Icons.menu_book_rounded,
    title: 'القصص الإسلامية',
    page: StoriesMenuPage.new,
    crossAxisCellCount: 4,
    mainAxisCellCount: 1.5,
    type: CardType.wide,
  ),
  _ServiceItem(
    icon: Icons.calendar_month_rounded,
    title: 'رمضان المبارك',
    page: RamadanPage.new,
  ),
  _ServiceItem(
    icon: Icons.volunteer_activism_rounded,
    title: 'أدعية مستجابة',
    page: PrayerPage.new,
  ),
  _ServiceItem(
    icon: Icons.format_list_numbered_rounded,
    title: 'الأربعون',
    page: NawawiPage.new,
    crossAxisCellCount: 2,
    mainAxisCellCount: 1,
    type: CardType.wide,
  ),
  _ServiceItem(
    icon: Icons.auto_stories_rounded,
    title: 'الشمائل',
    page: ShamailPage.new,
    crossAxisCellCount: 2,
    mainAxisCellCount: 1,
    type: CardType.wide,
  ),
  _ServiceItem(
    icon: Icons.format_quote_rounded,
    title: 'الحديث القدسي',
    page: QudsiPage.new,
    crossAxisCellCount: 4,
    mainAxisCellCount: 1.5,
    type: CardType.wide,
  ),
  _ServiceItem(
    icon: Icons.category_rounded,
    title: 'منوعات إسلامية',
    page: AnotherPage.new,
    crossAxisCellCount: 4,
    mainAxisCellCount: 1.5,
    type: CardType.wide,
  ),
];

// ---------------------------------------------------------------------------
// Page widget
// ---------------------------------------------------------------------------
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
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(gradient: AppTheme.mainGradient),
          ),

          // Decorative background icon
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
                      children: _services.map(_buildTile).toList(),
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

  /// Converts a [_ServiceItem] into a [StaggeredGridTile] with a [CardHome].
  StaggeredGridTile _buildTile(_ServiceItem item) {
    return StaggeredGridTile.count(
      crossAxisCellCount: item.crossAxisCellCount,
      mainAxisCellCount: item.mainAxisCellCount,
      child: CardHome(
        icon: item.icon,
        title: item.title,
        type: item.type,
        subtitle: item.subtitle,
        onClick: () => Get.to(
          item.page,
          transition: Transition.cupertino,
          duration: const Duration(milliseconds: 500),
        ),
      ),
    );
  }
}
