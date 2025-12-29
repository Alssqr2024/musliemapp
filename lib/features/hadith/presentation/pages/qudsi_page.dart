import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musliemapp/core/theme/app_theme.dart';
import 'package:musliemapp/features/hadith/data/datasources/hadith_local_data.dart';
import 'package:musliemapp/features/hadith/data/repositories/qudsi_repo_impl.dart';
import 'package:musliemapp/features/hadith/domain/usecases/qudsi_usecase.dart';
import 'package:musliemapp/features/hadith/presentation/controllers/qudsi_controller.dart';
import 'package:musliemapp/features/stories/presentation/pages/show_item_page.dart';

class QudsiPage extends StatelessWidget {
  const QudsiPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      QudsiController(
        qudsiUseCase: QudsiUseCase(
          qudsiRepo: QudsiRepoImpl(localData: HadithLocalData()),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('الحديث القدسي')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        } else {
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: controller.hadithList.length,
            itemBuilder: (context, index) {
              final hadith = controller.hadithList[index];
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
                      Icons.menu_book_rounded,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                  title: Text(hadith.arabic, style: AppTheme.heading2),
                  trailing: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                    color: AppTheme.textSecondary,
                  ),
                  onTap: () {
                    final stories = controller.hadithList.map((e) {
                      return StoryItem(
                        title: e.arabic,
                        content: e.english.text,
                      );
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
