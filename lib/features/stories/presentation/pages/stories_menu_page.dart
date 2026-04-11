import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/widgets/card_home.dart';
import '../../../../utils/widgets/main_scaffold.dart';
import '../../../../utils/widgets/premium_sliver_app_bar.dart';
import 'stories_page.dart';

class StoriesMenuPage extends StatelessWidget {
  const StoriesMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      slivers: [
        const PremiumSliverAppBar(
          title: 'قصص وعبر',
          icon: Icons.history_edu_rounded,
          subtitle: "سلسلة من القصص الإسلامية والعبر",
        ),

        SliverPadding(
                padding: const EdgeInsets.all(20),
                sliver: SliverGrid.count(
                  crossAxisCount: 2,
                  childAspectRatio: 0.85,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    _buildCard('قصص الأنبياء', 'prophets', Icons.auto_awesome),
                    _buildCard(
                      'قصص الصحابة',
                      'companions',
                      Icons.groups_rounded,
                    ),
                    _buildCard(
                      'قصص الصحابيات',
                      'female_companions',
                      Icons.woman_rounded,
                    ),
                    _buildCard('قصص القرآن', 'quran', Icons.menu_book_rounded),
                    _buildCard('قصص الحيوان', 'animals', Icons.pets_rounded),
                    _buildCard(
                      'معجزات الأنبياء',
                      'miracles',
                      Icons.star_rounded,
                    ),
                    _buildCard(
                      'زوجات الأنبياء',
                      'wives',
                      Icons.family_restroom_rounded,
                    ),
                    _buildCard('حياة الرسول', 'life', Icons.person_rounded),
                    _buildCard('عائلة الرسول', 'family', Icons.people_rounded),
                    _buildCard(
                      'غزوات الرسول',
                      'battles',
                      Icons.security_rounded,
                    ),
                    _buildCard(
                      'ملخص حياة الرسول',
                      'summary_life',
                      Icons.summarize_rounded,
                    ),
                  ],
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 40)),
            ],
    );
  }

  Widget _buildCard(String title, String category, IconData icon) {
    return CardHome(
      icon: icon,
      title: title,
      onClick: () {
        Get.to(
          () => StoriesPage(pageTitle: title, category: category),
          transition: Transition.cupertino,
          duration: const Duration(milliseconds: 500),
        );
      },
    );
  }
}
