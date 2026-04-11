import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musliemapp/core/bindings/ramadan_binding.dart';
import 'package:musliemapp/features/ramadan/domain/usecases/get_ramadan_items_usecase.dart';
import 'package:musliemapp/features/ramadan/presentation/controllers/ramadan_controller.dart';
import 'package:musliemapp/features/stories/presentation/pages/show_item_page.dart';
import 'package:musliemapp/features/ramadan/presentation/widgets/ramadan_item_card.dart';
import 'package:musliemapp/utils/widgets/main_scaffold.dart';
import 'package:musliemapp/utils/widgets/premium_sliver_app_bar.dart';

class RamadanItemsPage extends StatelessWidget {
  final String title;
  final String jsonFile;

  const RamadanItemsPage({
    super.key,
    required this.title,
    required this.jsonFile,
  });

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<GetRamadanItemsUseCase>()) {
      RamadanBinding().dependencies();
    }
    if (!Get.isRegistered<RamadanController>(tag: jsonFile)) {
      Get.put(
        RamadanController(getRamadanItemsUseCase: Get.find<GetRamadanItemsUseCase>()),
        tag: jsonFile,
      );
    }
    final controller = Get.find<RamadanController>(tag: jsonFile);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchItems(jsonFile);
    });

    return MainScaffold(
      slivers: [
        PremiumSliverAppBar(
          title: title,
          icon: Icons.calendar_month_rounded,
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
                      return RamadanItemCard(
                        index: index,
                        title: item.title,
                        content: item.content,
                        onTap: () {
                          final stories = controller.items.map((e) {
                            return StoryItem(
                              title: e.title,
                              content: e.content,
                            );
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

