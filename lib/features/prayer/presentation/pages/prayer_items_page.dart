import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musliemapp/core/theme/app_theme.dart';
import 'package:musliemapp/features/prayer/data/datasources/prayer_local_data.dart';
import 'package:musliemapp/features/prayer/data/repositories/prayer_repo_impl.dart';
import 'package:musliemapp/features/prayer/domain/usecases/get_prayer_items_usecase.dart';
import 'package:musliemapp/features/prayer/presentation/controllers/prayer_controller.dart';
import 'package:musliemapp/features/stories/presentation/pages/show_item_page.dart';

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
    final controller = Get.put(
      PrayerController(
        getPrayerItemsUseCase: GetPrayerItemsUseCase(
          prayerRepo: PrayerRepoImpl(localData: PrayerLocalData()),
        ),
      ),
      tag: jsonFile,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchItems(jsonFile);
    });

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        } else {
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: controller.items.length,
            itemBuilder: (context, index) {
              final item = controller.items[index];
              return Card(
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.mosque_rounded,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                  title: Text(item.text, style: AppTheme.heading2),
                  trailing: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                    color: AppTheme.textSecondary,
                  ),
                  onTap: () {
                    final stories = controller.items.map((e) {
                      return StoryItem(title: title, content: e.text);
                    }).toList();

                    Get.to(
                      () => ShowItemPage(stories: stories, initialIndex: index),
                      transition: Transition.fadeIn,
                      duration: const Duration(milliseconds: 500),
                    );
                  },
                ),
              );
            },
          );
        }
      }),
    );
  }
}
