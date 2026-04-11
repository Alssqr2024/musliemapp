import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:musliemapp/core/theme/app_theme.dart';
import 'package:musliemapp/core/utils/url_launcher_helper.dart';
import 'package:get/get.dart';

void showAboutBottomSheet(BuildContext context) {
  Get.bottomSheet(
    Container(
      margin: const EdgeInsets.all(16),
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).padding.bottom + 16,
      ),
      decoration: BoxDecoration(
        color: AppTheme.backgroundColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: const SingleChildScrollView(
          child: AboutAppCard(),
        ),
      ),
    ),
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    ignoreSafeArea: false,
    isDismissible: true,
    enableDrag: true,
  );
}

class AboutAppCard extends StatelessWidget {
  const AboutAppCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.15),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.info_outline_rounded, color: AppTheme.secondaryColor, size: 22),
                  const SizedBox(width: 8),
                  const Text(
                    'عن التطبيق والمطور',
                    style: TextStyle(
                      color: AppTheme.secondaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Tajawal',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'أذكار المسلم تطبيق إسلامي شامل يوفّر مواقيت الصلاة، الأذكار، الأحاديث، القرآن الكريم، اتجاه القبلة، وأدعية مستجابة. صُمم ليكون مرافقك اليومي في الذكر والدعاء.',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontSize: 14,
                  height: 1.6,
                  fontFamily: 'Tajawal',
                ),
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: 16),
              Text(
                'المطور',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Tajawal',
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'تم التطوير بعناية لخدمة المحتوى الإسلامي الموثوق. للاقتراحات أو الاستفسارات تواصل معنا عبر واتساب.',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontSize: 13,
                  height: 1.5,
                  fontFamily: 'Tajawal',
                ),
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: UrlLauncherHelper.openWhatsApp,
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: const Color(0xFF25D366).withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFF25D366).withValues(alpha: 0.5),
                          width: 1,
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.chat_rounded, color: Color(0xFF25D366), size: 24),
                          SizedBox(width: 10),
                          Text(
                            'تواصل عبر واتساب',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Tajawal',
                            ),
                          ),
                        ],
                      ),
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
}
