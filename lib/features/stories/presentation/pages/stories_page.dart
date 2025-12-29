import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../utils/constants/constants.dart';
import '../../data/datasources/stories_local_data.dart';
import '../../data/repositories/stories_repo_impl.dart';
import '../../domain/usecases/stories_usecase.dart';
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
    final controller = Get.put(
      StoriesController(
        storiesUseCase: StoriesUseCase(
          repo: StoriesRepoImpl(localData: StoriesLocalData()),
        ),
      ),
      tag: category,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchStories(category);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
        centerTitle: true,
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: controller.stories.length,
          itemBuilder: (context, index) {
            final story = controller.stories[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.menu_book_rounded,
                    color: AppTheme.primaryColor,
                  ),
                ),
                title: Text(
                  story.title,
                  style: const TextStyle(
                    fontFamily: Constants.fontTajawal,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: Colors.grey,
                ),
                onTap: () {
                  final stories = controller.stories.map((e) {
                    return StoryItem(title: e.title, content: e.content);
                  }).toList();

                  Get.to(
                    () => ShowItemPage(stories: stories, initialIndex: index),
                    transition: Transition.fade,
                    duration: const Duration(milliseconds: 500),
                  );
                },
              ),
            );
          },
        );
      }),
    );
  }
}
