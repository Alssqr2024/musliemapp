import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musliemapp/core/bindings/another_binding.dart';
import 'package:musliemapp/features/another/domain/usecases/get_another_items_usecase.dart';
import 'package:musliemapp/features/another/presentation/controllers/another_controller.dart';
import 'package:musliemapp/features/another/presentation/widgets/another_item_card.dart';
import 'package:musliemapp/features/stories/presentation/pages/show_item_page.dart';
import 'package:musliemapp/utils/widgets/main_scaffold.dart';
import 'package:musliemapp/utils/widgets/premium_sliver_app_bar.dart';

class AnotherItemsPage extends StatelessWidget {
  final String title;
  final String jsonFile;

  const AnotherItemsPage({
    super.key,
    required this.title,
    required this.jsonFile,
  });

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<GetAnotherItemsUseCase>()) {
      AnotherBinding().dependencies();
    }
    if (!Get.isRegistered<AnotherController>(tag: jsonFile)) {
      Get.put(
        AnotherController(getAnotherItemsUseCase: Get.find<GetAnotherItemsUseCase>()),
        tag: jsonFile,
      );
    }
    final controller = Get.find<AnotherController>(tag: jsonFile);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchItems(jsonFile);
    });

    IconData headerIcon = Icons.auto_stories_rounded;
    if (title.contains('وصية')) headerIcon = Icons.star_outline_rounded;
    if (title.contains('الإيمان')) headerIcon = Icons.favorite_border_rounded;
    if (title.contains('الجنة')) headerIcon = Icons.landscape_rounded;
    if (title.contains('الرقية')) headerIcon = Icons.shield_moon_outlined;
    if (title.contains('سنن')) headerIcon = Icons.event_repeat_rounded;
    if (title.contains('فرص')) headerIcon = Icons.auto_awesome_outlined;

    return MainScaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFFFFD700)),
          );
        }
        if (controller.items.isEmpty) {
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
            PremiumSliverAppBar(
              title: title,
              icon: headerIcon,
              subtitle: 'قائمة المحتويات المتاحة',
              useCircledIcon: true,
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final item = controller.items[index];
                  final preview = item.content.length > 150
                      ? '${item.content.replaceAll('\n', ' ').substring(0, 150)}...'
                      : item.content.replaceAll('\n', ' ');

                  return AnotherItemCard(
                    number: index + 1,
                    title: item.title,
                    preview: preview,
                    onTap: () {
                      final stories = controller.items.map((e) {
                        return StoryItem(title: e.title, content: e.content);
                      }).toList();
                      Get.to(
                        () =>
                            ShowItemPage(stories: stories, initialIndex: index),
                        transition: Transition.cupertino,
                        duration: const Duration(milliseconds: 400),
                      );
                    },
                  );
                }, childCount: controller.items.length),
              ),
            ),
          ],
        );
      }),
    );
  }
}

