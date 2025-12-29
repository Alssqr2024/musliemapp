import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../utils/widgets/card_home.dart';
import 'stories_page.dart';

class StoriesMenuPage extends StatelessWidget {
  const StoriesMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('القصص الإسلامية'),
        centerTitle: true,
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(16),
        crossAxisCount: 2,
        childAspectRatio: 0.85,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [
          _buildCard('قصص الأنبياء', 'prophets', Icons.history_edu),
          _buildCard('قصص الصحابة', 'companions', Icons.groups),
          _buildCard('قصص الصحابيات', 'female_companions', Icons.woman),
          _buildCard('قصص القرآن', 'quran', Icons.menu_book),
          _buildCard('قصص الحيوان', 'animals', Icons.pets),
          _buildCard('معجزات الأنبياء', 'miracles', Icons.auto_awesome),
          _buildCard('زوجات الأنبياء', 'wives', Icons.family_restroom),
          _buildCard('حياة الرسول', 'life', Icons.person),
          _buildCard('عائلة الرسول', 'family', Icons.people_outline),
          _buildCard('غزوات الرسول', 'battles', Icons.security),
          _buildCard('ملخص حياة الرسول', 'summary_life', Icons.summarize),
        ],
      ),
    );
  }

  Widget _buildCard(String title, String category, IconData icon) {
    return CardHome(
      icon: icon,
      title: title,
      onClick: () {
        Get.to(
          () => StoriesPage(pageTitle: title, category: category),
          transition: Transition.fadeIn,
        );
      },
    );
  }
}
