import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musliemapp/core/bindings/prayer_binding.dart';
import 'package:musliemapp/features/prayer/domain/usecases/get_prayer_items_usecase.dart';
import 'package:musliemapp/features/prayer/presentation/controllers/prayer_controller.dart';
import 'package:musliemapp/features/stories/presentation/pages/show_item_page.dart';
import 'package:musliemapp/features/prayer/presentation/widgets/prayer_item_card.dart';
import 'package:musliemapp/utils/widgets/main_scaffold.dart';
import 'package:musliemapp/utils/widgets/premium_sliver_app_bar.dart';

class PrayerItemsPage extends StatelessWidget {
  final String title;
  final String jsonFile;

  const PrayerItemsPage({
    super.key,
    required this.title,
    required this.jsonFile,
  });

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<GetPrayerItemsUseCase>()) {
      PrayerBinding().dependencies();
    }
    if (!Get.isRegistered<PrayerController>(tag: jsonFile)) {
      Get.put(
        PrayerController(getPrayerItemsUseCase: Get.find<GetPrayerItemsUseCase>()),
        tag: jsonFile,
      );
    }
    final controller = Get.find<PrayerController>(tag: jsonFile);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchItems(jsonFile);
    });

    return MainScaffold(
      slivers: [
        PremiumSliverAppBar(
          title: title,
          icon: Icons.mosque_rounded,
          useCircledIcon: true,
        ),

              // Items List
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: Obx(() {
                  if (controller.isLoading.value) {
                    return const SliverFillRemaining(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFFFFD700),
                        ),
                      ),
                    );
                  }

                  if (controller.errorMessage.isNotEmpty) {
                    return SliverFillRemaining(
                      child: Center(
                        child: Text(
                          controller.errorMessage.value,
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ),
                    );
                  }

                  return SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final item = controller.items[index];
                      return PrayerItemCard(
                        index: index,
                        title:
                            title, // Use folder title for consistency if item.text is content
                        content: item.text,
                        onTap: () {
                          final stories = controller.items.map((e) {
                            return StoryItem(title: title, content: e.text);
                          }).toList();

                          Get.to(
                            () => ShowItemPage(
                              stories: stories,
                              initialIndex: index,
                            ),
                            transition: Transition.cupertino,
                            duration: const Duration(milliseconds: 500),
                          );
                        },
                      );
                    }, childCount: controller.items.length),
                  );
                }),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 40)),
            ],
    );
  }
}

