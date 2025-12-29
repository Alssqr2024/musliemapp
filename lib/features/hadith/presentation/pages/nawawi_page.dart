import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musliemapp/features/hadith/data/datasources/hadith_local_data.dart';
import 'package:musliemapp/features/hadith/data/repositories/nawawi_repo_impl.dart';
import 'package:musliemapp/features/hadith/domain/usecases/nawawi_usecase.dart';
import 'package:musliemapp/features/hadith/presentation/controllers/nawawi_controller.dart';
import 'package:musliemapp/features/stories/presentation/pages/show_item_page.dart';
import 'package:musliemapp/utils/constants/constants.dart';

class NawawiPage extends StatelessWidget {
  const NawawiPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      NawawiController(
        nawawiUseCase: NawawiUseCase(
          nawawiRepo: NawawiRepoImpl(localData: HadithLocalData()),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('الاربعين النووية'),
        centerTitle: true,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        }

        if (controller.nawawis.isEmpty) {
          return const Center(child: Text('لا يوجد بيانات'));
        }

        return ListView.builder(
          itemCount: controller.nawawis.length,
          itemBuilder: (context, index) {
            final nawawi = controller.nawawis[index];
            return Card(
              child: ListTile(
                leading: const Icon(Icons.book),
                title: Text(
                  nawawi.hadith,
                  style: const TextStyle(fontFamily: Constants.fontTajawal),
                ),
                onTap: () {
                  final stories = controller.nawawis.map((e) {
                    return StoryItem(title: e.hadith, content: e.description);
                  }).toList();

                  Get.to(
                    () => ShowItemPage(stories: stories, initialIndex: index),
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
