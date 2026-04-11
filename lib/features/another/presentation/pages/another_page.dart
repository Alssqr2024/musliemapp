import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:musliemapp/utils/constants/file_json.dart';
import 'package:musliemapp/utils/widgets/card_home.dart';
import 'package:musliemapp/utils/widgets/main_scaffold.dart';
import 'package:musliemapp/utils/widgets/premium_sliver_app_bar.dart';
import 'package:musliemapp/features/another/presentation/pages/another_items_page.dart';

class AnotherPage extends StatelessWidget {
  const AnotherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      slivers: [
        const PremiumSliverAppBar(
          title: 'منوعات إسلامية',
          icon: Icons.dashboard_customize_rounded,
          subtitle: 'موسوعة من الوصايا والسنن والفضائل',
          useCircledIcon: true,
        ),
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
