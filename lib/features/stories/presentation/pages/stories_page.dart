import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musliemapp/core/bindings/stories_binding.dart';
import 'package:musliemapp/features/stories/domain/usecases/stories_usecase.dart';
import 'package:musliemapp/utils/widgets/main_scaffold.dart';
import 'package:musliemapp/utils/widgets/premium_sliver_app_bar.dart';
import '../controllers/stories_controller.dart';
import 'show_item_page.dart';

class StoriesPage extends StatelessWidget {
  final String pageTitle;
  final String category;

  const StoriesPage({
    super.key,
    required this.pageTitle,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<StoriesUseCase>()) {
      StoriesBinding().dependencies();
    }
    if (!Get.isRegistered<StoriesController>(tag: category)) {
      Get.put(
        StoriesController(storiesUseCase: Get.find<StoriesUseCase>()),
        tag: category,
      );
    }
    final controller = Get.find<StoriesController>(tag: category);

    if (controller.stories.isEmpty && !controller.isLoading.value) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.fetchStories(category);
      });
    }

    return MainScaffold(
      slivers: [
        PremiumSliverAppBar(
          title: pageTitle,
          icon: Icons.auto_stories_rounded,
          useCircledIcon: true,
        ),

        // Content List
        SliverPadding(
                padding: const EdgeInsets.all(20),
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
                      final story = controller.stories[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                        child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.05),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.1),
                                ),
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 8,
                                ),
                                leading: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: const Color(
                                      0xFFFFD700,
                                    ).withValues(alpha: 0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.menu_book_rounded,
                                    color: Color(0xFFFFD700),
                                    size: 20,
                                  ),
                                ),
                                title: Text(
                                  story.title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                trailing: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 14,
                                  color: Colors.white54,
                                ),
                                onTap: () {
                                  final storiesList = controller.stories.map((
                                    e,
                                  ) {
                                    return StoryItem(
                                      title: e.title,
                                      content: e.content,
                                    );
                                  }).toList();

                                  Get.to(
                                    () => ShowItemPage(
                                      stories: storiesList,
                                      initialIndex: index,
                                    ),
                                    transition: Transition.cupertino,
                                    duration: const Duration(milliseconds: 500),
                                  );
                                },
                              ),
                            ),
                          ),
                      );
                    }, childCount: controller.stories.length),
                  );
                }),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 40)),
            ],
    );
  }
}
