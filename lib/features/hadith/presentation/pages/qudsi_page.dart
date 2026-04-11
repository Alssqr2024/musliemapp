import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musliemapp/core/theme/app_theme.dart';
import 'package:musliemapp/core/bindings/hadith_bindings.dart';
import 'package:musliemapp/features/hadith/presentation/controllers/qudsi_controller.dart';
import 'package:musliemapp/features/stories/presentation/pages/show_item_page.dart';
import 'package:musliemapp/features/hadith/presentation/widgets/hadith_card.dart';
import 'package:musliemapp/utils/widgets/main_scaffold.dart';
import 'package:musliemapp/utils/widgets/premium_sliver_app_bar.dart';

class QudsiPage extends StatelessWidget {
  const QudsiPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize binding if not already done
    if (!Get.isRegistered<QudsiController>()) {
      HadithBindings().dependencies();
    }
    final controller = Get.find<QudsiController>();

    return MainScaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: AppTheme.secondaryColor),
          );
        }
        if (controller.hadithList.isEmpty) {
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
              title: 'الحديث القدسي',
              icon: Icons.format_quote_rounded,
              subtitle: 'كلام الله تعالى بغير لفظ القرآن',
              useCircledIcon: true,
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final hadith = controller.hadithList[index];
                  final displayTitle = hadith.title ?? "الحديث ${index + 1}";
                  final preview = hadith.arabic.length > 150
                      ? '${hadith.arabic.substring(0, 150)}...'
                      : hadith.arabic;

                  return HadithCard(
                    number: index + 1,
                    title: displayTitle,
                    preview: preview,
                    onTap: () {
                      final items = controller.hadithList.map((e) {
                        return StoryItem(
                          title: e.title ?? "الحديث القدسي",
                          content: e.arabic,
                        );
                      }).toList();
                      Get.to(
                        () => ShowItemPage(stories: items, initialIndex: index),
                        transition: Transition.cupertino,
                        duration: const Duration(milliseconds: 400),
                      );
                    },
                  );
                }, childCount: controller.hadithList.length),
              ),
            ),
          ],
        );
      }),
    );
  }
}

// ─── Reusable Hadith Card ─────────────────────────────────────────────────────
