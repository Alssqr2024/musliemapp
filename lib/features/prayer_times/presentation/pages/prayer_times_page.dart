import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musliemapp/core/theme/app_theme.dart';
import 'package:musliemapp/features/prayer_times/presentation/controllers/prayer_times_controller.dart';
import 'package:musliemapp/core/services/notification_service.dart';
import 'package:musliemapp/utils/widgets/main_scaffold.dart';
import 'package:musliemapp/utils/widgets/premium_sliver_app_bar.dart';

class PrayerTimesPage extends StatelessWidget {
  const PrayerTimesPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Controller is already initialized via AppBindings
    final controller = Get.find<PrayerTimesController>();

    return MainScaffold(
      slivers: [
        Obx(() => PremiumSliverAppBar(
          title: 'مواقيت الصلاة',
          icon: Icons.access_time_filled_rounded,
          subtitle: controller.locationSource.value,
          useCircledIcon: true,
          expandedHeight: 220,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.notifications_active_rounded,
                color: AppTheme.secondaryColor,
              ),
              onPressed: () {
                Get.defaultDialog(
                  title: 'اختبار الإشعارات',
                  titleStyle: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Tajawal'),
                  middleText: 'يمكنك تجربة الإشعار فوراً، أو جدولته بعد 30 ثانية لتتمكن من إغلاق التطبيق والتأكد من عمله في الخلفية.',
                  middleTextStyle: const TextStyle(fontFamily: 'Tajawal', height: 1.5),
                  backgroundColor: AppTheme.backgroundColor,
                  titlePadding: const EdgeInsets.only(top: 20, bottom: 10),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  radius: 16,
                  confirm: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor),
                    onPressed: () async {
                      Get.back();
                      await NotificationService().sendTestNotification();
                    },
                    child: const Text('تجربة فورية', style: TextStyle(color: Colors.white, fontFamily: 'Tajawal')),
                  ),
                  cancel: OutlinedButton(
                    style: OutlinedButton.styleFrom(side: const BorderSide(color: AppTheme.secondaryColor)),
                    onPressed: () async {
                      Get.back();
                      await NotificationService().scheduleTestNotification(seconds: 30);
                      Get.snackbar(
                        'تمت الجدولة بنجاح ✔️',
                        'قم بالخروج من التطبيق تماماً الآن وانتظر 30 ثانية لترى الإشعار.',
                        backgroundColor: Colors.green.withValues(alpha: 0.8),
                        colorText: Colors.white,
                        snackPosition: SnackPosition.TOP,
                        margin: const EdgeInsets.all(16),
                        borderRadius: 12,
                        duration: const Duration(seconds: 5),
                      );
                    },
                    child: const Text('بعد 30 ثانية', style: TextStyle(color: AppTheme.secondaryColor, fontFamily: 'Tajawal')),
                  ),
                );
              },
              tooltip: 'اختبار الإشعار',
            ),
            IconButton(
              icon: const Icon(Icons.refresh_rounded, color: Colors.white),
              onPressed: controller.loadPrayerTimes,
              tooltip: 'تحديث',
            ),
          ],
        )),
          SliverToBoxAdapter(
            child: Obx(() {
              if (controller.isLoading.value) {
                return _buildLoading();
              }
              if (controller.errorMessage.isNotEmpty) {
                return _buildError(controller);
              }
              return _buildContent(controller);
            }),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 32)),
      ],
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: Colors.white70),
          SizedBox(height: 16),
          Text(
            'جاري تحديد موقعك...',
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildError(PrayerTimesController c) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.location_off,
                    size: 64,
                    color: Colors.orangeAccent,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    c.errorMessage.value,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: c.loadPrayerTimes,
                    icon: const Icon(Icons.refresh),
                    label: const Text('إعادة المحاولة'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF203A43),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(PrayerTimesController c) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildNextPrayerCard(c),
          const SizedBox(height: 8),
          Obx(
            () => Text(
              'الموقع: ${c.locationSource.value}',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white54,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          const SizedBox(height: 20),
          _buildPrayerCard('الفجر', c.fajrTime.value, Icons.wb_twilight),
          _buildPrayerCard(
            'الشروق',
            c.sunriseTime.value,
            Icons.wb_sunny_outlined,
          ),
          _buildPrayerCard('الظهر', c.dhuhrTime.value, Icons.wb_sunny),
          _buildPrayerCard('العصر', c.asrTime.value, Icons.cloud_outlined),
          _buildPrayerCard(
            'المغرب',
            c.maghribTime.value,
            Icons.nights_stay_outlined,
          ),
          _buildPrayerCard('العشاء', c.ishaTime.value, Icons.nightlight),
        ],
      ),
    );
  }

  Widget _buildNextPrayerCard(PrayerTimesController c) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            gradient: LinearGradient(
              colors: [
                Colors.white.withValues(alpha: 0.1),
                Colors.white.withValues(alpha: 0.05),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Obx(
            () => Column(
              children: [
                const Icon(
                  Icons.access_time_filled,
                  color: Colors.white54,
                  size: 36,
                ),
                const SizedBox(height: 12),
                const Text(
                  'الصلاة القادمة',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  c.nextPrayerName.value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  c.nextPrayerTime.value,
                  style: const TextStyle(color: Colors.white70, fontSize: 20),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.secondaryColor,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.secondaryColor.withValues(alpha: 0.3),
                        blurRadius: 15,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Text(
                    c.remainingFormatted,
                    style: const TextStyle(
                      color: Color(0xFF0F2027),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPrayerCard(String name, String time, IconData icon) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppTheme.secondaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: AppTheme.secondaryColor, size: 24),
              ),
              const SizedBox(width: 20),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              Text(
                time,
                style: const TextStyle(
                  fontSize: 17,
                  color: AppTheme.secondaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
