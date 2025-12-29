import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musliemapp/features/hadith/data/datasources/hadith_local_data.dart';
import 'package:musliemapp/features/hadith/data/repositories/shamail_repo_impl.dart';
import 'package:musliemapp/features/hadith/domain/usecases/shamail_usecase.dart';
import 'package:musliemapp/features/hadith/presentation/controllers/shamail_controller.dart';
import 'package:musliemapp/features/stories/presentation/pages/show_item_page.dart';
import 'package:musliemapp/utils/constants/constants.dart';

class ShamailPage extends StatelessWidget {
  const ShamailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      ShamailController(
        shamailUseCase: ShamailUseCase(
          shamailRepo: ShamailRepoImpl(localData: HadithLocalData()),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('الشمائل المحمدية'),
        centerTitle: true,
        // backgroundColor: Colors.green,
        // foregroundColor: Colors.white,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        }

        if (controller.shamails.isEmpty) {
          return const Center(child: Text("لا يوجد بيانات"));
        }

        /// الكتاب الوحيد داخل القائمة
        final book = controller.shamails[0];

        /// قائمة الفصول
        final chapters = book.chapters;

        return ListView.builder(
          itemCount: chapters.length,
          itemBuilder: (context, index) {
            final chapter = chapters[index];

            return Card(
              child: ListTile(
                leading: const Icon(Icons.book),
                title: Text(
                  chapter.arabic,
                  style: const TextStyle(fontFamily: Constants.fontTajawal),
                ),
                onTap: () {
                  /// الأحاديث التي تخص هذا الفصل فقط
                  final chapterHadiths = book.hadiths
                      .where((h) => h.chapterId == chapter.id)
                      .toList();

                  final stories = chapterHadiths.map((h) {
                    return StoryItem(title: chapter.arabic, content: h.arabic);
                  }).toList();

                  if (stories.isEmpty) {
                    stories.add(
                      StoryItem(
                        title: chapter.arabic,
                        content: "لا يوجد حديث لهذا الفصل",
                      ),
                    );
                  }

                  Get.to(
                    () => ShowItemPage(
                      stories: stories,
                      initialIndex:
                          0, // Always start from 0 for this chapter's list
                    ),
                    transition: Transition.fade,
                    duration: const Duration(milliseconds: 1000),
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
