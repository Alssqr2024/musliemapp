import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musliemapp/core/theme/app_theme.dart';
import 'package:musliemapp/core/bindings/hadith_bindings.dart';
import 'package:musliemapp/features/hadith/presentation/controllers/shamail_controller.dart';
import 'package:musliemapp/features/stories/presentation/pages/show_item_page.dart';
import 'package:musliemapp/features/hadith/presentation/widgets/chapter_card.dart';
import 'package:musliemapp/utils/widgets/main_scaffold.dart';
import 'package:musliemapp/utils/widgets/premium_sliver_app_bar.dart';

class ShamailPage extends StatelessWidget {
  const ShamailPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize binding if not already done
    if (!Get.isRegistered<ShamailController>()) {
      HadithBindings().dependencies();
    }
    final controller = Get.find<ShamailController>();

    return MainScaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: AppTheme.secondaryColor),
          );
        }
        if (controller.shamails.isEmpty) {
          return const Center(
            child: Text(
              'لا يوجد بيانات',
              style: TextStyle(color: Colors.white70),
            ),
          );
        }

        final book = controller.shamails[0];
        final chapters = book.chapters;
        final meta = book.metadata.isNotEmpty ? book.metadata[0] : null;

        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            PremiumSliverAppBar(
              title: meta?.title ?? 'الشمائل المحمدية',
              icon: Icons.auto_stories_rounded,
              subtitle: 'للإمام أبي عيسى الترمذي',
              expandedHeight: 220,
              useCircledIcon: true,
              showDecorativeCircles: true,
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final chapter = chapters[index];
                  final chapterHadiths = book.hadiths
                      .where((h) => h.chapterId == chapter.id)
                      .toList();

                  return ChapterCard(
                    number: index + 1,
                    title: chapter.arabic,
                    hadithCount: chapterHadiths.length,
                    onTap: () {
                      final stories = chapterHadiths.map((h) {
                        return StoryItem(
                          title: chapter.arabic,
                          content: h.arabic,
                        );
                      }).toList();

                      if (stories.isEmpty) {
                        stories.add(
                          StoryItem(
                            title: chapter.arabic,
                            content: 'لا يوجد حديث لهذا الفصل',
                          ),
                        );
                      }

                      Get.to(
                        () => ShowItemPage(stories: stories, initialIndex: 0),
                        transition: Transition.cupertino,
                        duration: const Duration(milliseconds: 400),
                      );
                    },
                  );
                }, childCount: chapters.length),
              ),
            ),
          ],
        );
      }),
    );
  }
}

