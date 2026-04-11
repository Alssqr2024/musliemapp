import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:musliemapp/core/theme/app_theme.dart';
import 'package:musliemapp/core/bindings/names_allah_binding.dart';
import 'package:musliemapp/features/names_of_allah/presentation/controllers/names_allah_controller.dart';
import 'package:musliemapp/features/names_of_allah/presentation/widgets/name_card.dart';
import 'package:musliemapp/utils/constants/constants.dart';
import 'package:musliemapp/utils/widgets/main_scaffold.dart';
import 'package:musliemapp/utils/widgets/premium_sliver_app_bar.dart';

class NamesAllahPage extends StatelessWidget {
  const NamesAllahPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<NamesAllahController>()) {
      NamesAllahBinding().dependencies();
    }
    final controller = Get.find<NamesAllahController>();

    return MainScaffold(
      slivers: [
        const PremiumSliverAppBar(
          title: 'أسماء الله الحسنى',
          icon: Icons.star_outline_rounded,
          subtitle: 'من أحصاها دخل الجنة',
          useCircledIcon: true,
          showDecorativeCircles: true,
        ),

        // Names Grid
        SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                sliver: Obx(() {
                  if (controller.isLoading.value) {
                    return const SliverFillRemaining(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppTheme.secondaryColor,
                        ),
                      ),
                    );
                  }

                  if (controller.errorMessage.isNotEmpty) {
                    return SliverFillRemaining(
                      child: Center(
                        child: Text(
                          controller.errorMessage.value,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontFamily: Constants.fontTajawal,
                          ),
                        ),
                      ),
                    );
                  }

                  return SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 0.9,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final name = controller.namesList[index];
                      return NameCard(
                        index: index,
                        name: name.name,
                        onTap: () => _showNameDetail(
                          context,
                          index,
                          name.name,
                          name.text,
                        ),
                      );
                    }, childCount: controller.namesList.length),
                  );
                }),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 40)),
            ],
    );
  }

  void _showNameDetail(
    BuildContext context,
    int index,
    String nameStr,
    String desc,
  ) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 60,
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppTheme.surfaceColor,
                AppTheme.backgroundColor,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(32),
            border: Border.all(
              color: AppTheme.secondaryColor.withValues(alpha: 0.28),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.5),
                blurRadius: 30,
                spreadRadius: 5,
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(28),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // رقم الاسم
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.secondaryColor.withValues(alpha: 0.15),
                      border: Border.all(
                        color: AppTheme.secondaryColor.withValues(alpha: 0.4),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(
                          color: AppTheme.secondaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: Constants.fontTajawal,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // الاسم الكريم — بتصميم مُحتفى به
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        colors: [
                          AppTheme.secondaryColor.withValues(alpha: 0.12),
                          AppTheme.secondaryColor.withValues(alpha: 0.03),
                        ],
                        radius: 1.2,
                      ),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: AppTheme.secondaryColor.withValues(alpha: 0.25),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      nameStr,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: Constants.fontTajawal,
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.secondaryColor,
                        height: 1.35,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  Container(
                    height: 1,
                    color: Colors.white.withValues(alpha: 0.08),
                  ),
                  const SizedBox(height: 20),

                  // الشرح
                  Text(
                    desc,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: Constants.fontTajawal,
                      color: AppTheme.textPrimary,
                      fontSize: 16,
                      height: 1.75,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 28),

                  // أزرار
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            Clipboard.setData(ClipboardData(text: '$nameStr\n\n$desc'));
                            Get.snackbar(
                              '',
                              'تم النسخ',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.white.withValues(alpha: 0.1),
                              colorText: Colors.white,
                              borderRadius: 16,
                              margin: const EdgeInsets.all(16),
                              duration: const Duration(seconds: 2),
                            );
                          },
                          icon: const Icon(Icons.copy_rounded, size: 16),
                          label: const Text(
                            'نسخ',
                            style: TextStyle(fontFamily: Constants.fontTajawal),
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white70,
                            side: BorderSide(
                              color: Colors.white.withValues(alpha: 0.2),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Get.back(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.secondaryColor.withValues(alpha: 0.15),
                            foregroundColor: AppTheme.secondaryColor,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                              side: BorderSide(
                                color: AppTheme.secondaryColor.withValues(alpha: 0.4),
                              ),
                            ),
                          ),
                          child: const Text(
                            'إغلاق',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: Constants.fontTajawal,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

