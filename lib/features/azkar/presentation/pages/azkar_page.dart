import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musliemapp/features/azkar/data/datasources/azkar_local_data.dart';
import 'package:musliemapp/features/azkar/data/repositories/azkar_repo_impl.dart';
import 'package:musliemapp/features/azkar/domain/usecases/azkar_usecase.dart';
import 'package:musliemapp/features/azkar/presentation/controllers/azkar_controller.dart';
import 'package:musliemapp/features/azkar/presentation/pages/show_azkar_page.dart';
import 'package:musliemapp/utils/widgets/card_home.dart';

class AzkarPage extends StatelessWidget {
  const AzkarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      AzkarController(
        azkarUseCase: AzkarUsecase(
          azkarRepo: AzkarRepoImpl(localData: AzkarLocalData()),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('حصن المسلم')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        } else {
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: controller.azkarList.length,
            itemBuilder: (context, index) {
              final azkar = controller.azkarList[index];
              return CardHome(
                icon: Icons.menu_book_rounded,
                title: azkar.category,
                onClick: () {
                  Get.to(
                    () =>
                        ShowAzkarPage(title: azkar.category, data: azkar.array),
                    transition: Transition.fadeIn,
                    duration: const Duration(milliseconds: 500),
                  );
                },
              );
            },
          );
        }
      }),
    );
  }
}
