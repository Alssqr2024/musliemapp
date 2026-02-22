import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musliemapp/core/theme/app_theme.dart';
import 'package:intl/intl.dart';
import 'package:musliemapp/features/prayer_times/presentation/controllers/prayer_times_controller.dart';

class MosqueCalendarCard extends StatelessWidget {
  final bool isCompact;

  const MosqueCalendarCard({super.key, this.isCompact = false});

  @override
  Widget build(BuildContext context) {
    final PrayerTimesController controller = Get.find<PrayerTimesController>();

    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.2),
              width: 1.5,
            ),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white24, Colors.white10],
            ),
          ),
          child: Column(
            children: [
              // 1. Top Section: Moon & Ramadan Countdown
              _buildTopInfo(controller),

              const SizedBox(height: 1),
              Container(
                height: 1,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                color: Colors.white10,
              ),

              // 2. Main content: Dates
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    _buildModernDateSection(controller),

                    Obx(
                      () => Column(
                        children: [
                          if (!isCompact) ...[
                            const SizedBox(height: 24),
                            _buildModernDailyCard(
                              icon: Icons.auto_awesome_rounded,
                              title: 'ذكر اليوم',
                              content: controller.dayDhikr.value,
                              isPrimary: true,
                            ),
                            const SizedBox(height: 16),
                            _buildModernDailyCard(
                              icon: Icons.auto_stories_rounded,
                              title: 'حديث اليوم',
                              content: controller.dayHadith.value,
                              narrator: controller.hadithNarrator.value,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              if (!isCompact)
                // Footer
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withValues(alpha: 0.2),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'أذكار المسلم - حِيَاضُ الذِّكْرِ',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                        fontFamily: 'Tajawal',
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopInfo(PrayerTimesController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppTheme.secondaryColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Obx(
                () => Icon(
                  controller.moonPhaseIcon.value,
                  color: AppTheme.secondaryColor,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Obx(
              () => Text(
                controller.moonPhaseName.value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Tajawal',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernDateSection(PrayerTimesController controller) {
    return Obx(() {
      final hijri = controller.hijriDate.value;
      final georgian = controller.georgianDate.value;

      return Column(
        children: [
          // Hijri Date - Primary
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            textBaseline: TextBaseline.alphabetic,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            children: [
              Text(
                hijri.hDay.toString(),
                style: const TextStyle(
                  color: AppTheme.secondaryColor,
                  fontSize: 48,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Tajawal',
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.arabicHijriMonth.value,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Tajawal',
                    ),
                  ),
                  Text(
                    hijri.hYear.toString(),
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Tajawal',
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Georgian Date - Secondary
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              DateFormat('d MMMM yyyy', 'ar').format(georgian),
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontFamily: 'Tajawal',
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget _buildModernDailyCard({
    required IconData icon,
    required String title,
    required String content,
    String? narrator,
    bool isPrimary = false,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isPrimary
            ? Colors.white.withValues(alpha: 0.08)
            : Colors.black.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isPrimary
              ? AppTheme.secondaryColor.withValues(alpha: 0.2)
              : Colors.white.withValues(alpha: 0.05),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppTheme.secondaryColor, size: 18),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  color: AppTheme.secondaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Tajawal',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            content,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              height: 1.6,
              fontWeight: FontWeight.w600,
              fontFamily: 'Tajawal',
            ),
          ),
          if (narrator != null) ...[
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                narrator,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.4),
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  fontFamily: 'Tajawal',
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
