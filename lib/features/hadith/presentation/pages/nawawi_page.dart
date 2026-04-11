import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musliemapp/core/theme/app_theme.dart';
import 'package:musliemapp/core/bindings/hadith_bindings.dart';
import 'package:musliemapp/features/hadith/presentation/controllers/nawawi_controller.dart';
import 'package:musliemapp/features/stories/presentation/pages/show_item_page.dart';
import 'package:musliemapp/features/hadith/presentation/widgets/hadith_card.dart';
import 'package:musliemapp/utils/widgets/main_scaffold.dart';
import 'package:musliemapp/utils/widgets/premium_sliver_app_bar.dart';

class NawawiPage extends StatelessWidget {
  const NawawiPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize binding if not already done
    if (!Get.isRegistered<NawawiController>()) {
      HadithBindings().dependencies();
    }
    final controller = Get.find<NawawiController>();

    return MainScaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: AppTheme.secondaryColor),
          );
        }
        if (controller.nawawis.isEmpty) {
          return const Center(
            child: Text(
              'لا يوجد بيانات',
              style: TextStyle(color: Colors.white70),
            ),
          );
        }

        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            const PremiumSliverAppBar(
              title: 'الأربعون النووية',
              icon: Icons.auto_stories_rounded,
              subtitle: 'للإمام يحيى بن شرف النووي',
              useCircledIcon: true,
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final nawawi = controller.nawawis[index];
                  final displayTitle = nawawi.title ?? "الحديث ${index + 1}";
                  final preview = nawawi.description.length > 150
                      ? '${nawawi.description.substring(0, 150)}...'
                      : nawawi.description;

                  return HadithCard(
                    number: index + 1,
                    title: displayTitle,
                    preview: preview,
                    onTap: () {
                      final items = controller.nawawis.map((e) {
                        return StoryItem(
                          title: e.title ?? "الحديث النووي",
                          content:
                              "المتن:\n${e.hadith}\n\nالشرح:\n${e.description}",
                        );
                      }).toList();
                      Get.to(
                        () => ShowItemPage(stories: items, initialIndex: index),
                        transition: Transition.cupertino,
                        duration: const Duration(milliseconds: 400),
                      );
                    },
                  );
                }, childCount: controller.nawawis.length),
              ),
            ),
          ],
        );
      }),
    );
  }
}

