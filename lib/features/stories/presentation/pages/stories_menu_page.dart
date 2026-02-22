import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/widgets/card_home.dart';
import 'stories_page.dart';

class StoriesMenuPage extends StatelessWidget {
  const StoriesMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F2027),
      body: Stack(
        children: [
          // Background Gradient
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

          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Premium SliverAppBar
              SliverAppBar(
                expandedHeight: 200,
                floating: false,
                pinned: true,
                backgroundColor: const Color(0xFF0F2027),
                elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(
                    'قصص وعبر',
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
                      // Header Decorations
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 20),
                            const Icon(
                              Icons.history_edu_rounded,
                              size: 50,
                              color: Color(0xFFFFD700),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "سلسلة من القصص الإسلامية والعبر",
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 13,
                                letterSpacing: 1.1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
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
          ),
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
          transition: Transition.cupertino,
          duration: const Duration(milliseconds: 500),
        );
      },
    );
  }
}
