import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:musliemapp/utils/constants/file_json.dart';
import 'package:musliemapp/utils/widgets/card_home.dart';
import 'package:musliemapp/features/another/presentation/pages/another_items_page.dart';

class AnotherPage extends StatelessWidget {
  const AnotherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F2027),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildSliverHeader(),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
            sliver: SliverGrid.count(
              crossAxisCount: 2,
              childAspectRatio: 0.95,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildItem(
                  context,
                  '55 وصية من النبي',
                  another55Wasiya,
                  Icons.star_outline_rounded,
                ),
                _buildItem(
                  context,
                  'الإيمان بالله',
                  anotherIman,
                  Icons.favorite_border_rounded,
                ),
                _buildItem(
                  context,
                  'الجنة ونعيمها',
                  anotherJannah,
                  Icons.landscape_rounded,
                ),
                _buildItem(
                  context,
                  'الرقية الشرعية',
                  anotherRuqyah,
                  Icons.shield_moon_outlined,
                ),
                _buildItem(
                  context,
                  'رياض الصالحين',
                  anotherRiyad,
                  Icons.menu_book_rounded,
                ),
                _buildItem(
                  context,
                  'سنن مؤكدة',
                  anotherSunan,
                  Icons.event_repeat_rounded,
                ),
                _buildItem(
                  context,
                  'علمني الإسلام',
                  anotherTeachMe,
                  Icons.school_outlined,
                ),
                _buildItem(
                  context,
                  'فرص ذهبية',
                  anotherGold,
                  Icons.auto_awesome_outlined,
                ),
                _buildItem(
                  context,
                  'فضائل الأعمال',
                  anotherFadail,
                  Icons.volunteer_activism_outlined,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverHeader() {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      backgroundColor: const Color(0xFF0F2027),
      elevation: 0,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          'منوعات إسلامية',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
            shadows: [
              Shadow(
                blurRadius: 10,
                color: Colors.black.withOpacity(0.5),
                offset: const Offset(0, 2),
              ),
            ],
          ),
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF0F2027),
                    Color(0xFF203A43),
                    Color(0xFF2C5364),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFFFD700).withOpacity(0.1),
                      border: Border.all(
                        color: const Color(0xFFFFD700).withOpacity(0.3),
                        width: 1.5,
                      ),
                    ),
                    child: const Icon(
                      Icons.dashboard_customize_rounded,
                      color: Color(0xFFFFD700),
                      size: 32,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'موسوعة من الوصايا والسنن والفضائل',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(
    BuildContext context,
    String title,
    String jsonFile,
    IconData icon,
  ) {
    return CardHome(
      icon: icon,
      title: title,
      onClick: () {
        Get.to(
          () => AnotherItemsPage(title: title, jsonFile: jsonFile),
          transition: Transition.cupertino,
          duration: const Duration(milliseconds: 500),
        );
      },
    );
  }
}
