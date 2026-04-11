import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musliemapp/core/bindings/azkar_binding.dart';
import 'package:musliemapp/features/azkar/presentation/controllers/azkar_controller.dart';
import 'package:musliemapp/features/azkar/presentation/pages/show_azkar_page.dart';
import 'package:musliemapp/utils/widgets/card_home.dart';
import 'package:musliemapp/utils/widgets/main_scaffold.dart';
import 'package:musliemapp/utils/widgets/premium_sliver_app_bar.dart';

class AzkarPage extends StatelessWidget {
  const AzkarPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize binding if not already done
    if (!Get.isRegistered<AzkarController>()) {
      AzkarBinding().dependencies();
    }
    final controller = Get.find<AzkarController>();

    return MainScaffold(
      slivers: [
        const PremiumSliverAppBar(
          title: 'حصن المسلم',
          icon: Icons.menu_book_rounded,
          subtitle: "مجموعة الأذكار والأدعية",
        ),

              // Categories Grid
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

                  return SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.85,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final azkar = controller.azkarList[index];
                      return CardHome(
                        icon: Icons.auto_awesome_rounded,
                        title: azkar.category,
                        onClick: () {
                          Get.to(
                            () => ShowAzkarPage(
                              title: azkar.category,
                              data: azkar.array,
                            ),
                            transition: Transition.cupertino,
                            duration: const Duration(milliseconds: 500),
                          );
                        },
                      );
                    }, childCount: controller.azkarList.length),
                  );
                }),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 40)),
            ],
    );
  }
}
