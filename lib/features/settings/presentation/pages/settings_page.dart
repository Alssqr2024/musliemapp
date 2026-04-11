import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kIsWeb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musliemapp/core/theme/app_theme.dart';
import 'package:musliemapp/core/utils/url_launcher_helper.dart';
import 'package:musliemapp/features/settings/presentation/controllers/settings_controller.dart';
import 'package:musliemapp/utils/widgets/main_scaffold.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsPage extends GetView<SettingsController> {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                    color: Colors.white,
                  ),
                  const Expanded(
                    child: Text(
                      'الإعدادات',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Tajawal',
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
                physics: const BouncingScrollPhysics(),
                children: [
                  _sectionTitle('التنبيهات'),
                  _card(
                    child: Column(
                      children: [
                        Obx(
                          () => SwitchListTile.adaptive(
                            value: controller.notifyPrayer.value,
                            onChanged: (v) => controller.setNotifyPrayer(v),
                            title: const Text(
                              'تنبيهات مواقيت الصلاة',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Tajawal',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Text(
                              'إشعار عند دخول وقت كل صلاة',
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.65),
                                fontSize: 13,
                                fontFamily: 'Tajawal',
                              ),
                            ),
                            activeThumbColor: AppTheme.secondaryColor,
                            inactiveThumbColor: Colors.white54,
                            inactiveTrackColor: Colors.white24,
                          ),
                        ),
                        const Divider(height: 1, color: Colors.white12),
                        Obx(
                          () => SwitchListTile.adaptive(
                            value: controller.notifyQuranDaily.value,
                            onChanged: (v) =>
                                controller.setNotifyQuranDaily(v),
                            title: const Text(
                              'تنبيه الورد اليومي (القرآن)',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Tajawal',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Text(
                              'تذكير يومي بوقت تختاره لقراءة القرآن',
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.65),
                                fontSize: 13,
                                fontFamily: 'Tajawal',
                              ),
                            ),
                            activeThumbColor: AppTheme.secondaryColor,
                            inactiveThumbColor: Colors.white54,
                            inactiveTrackColor: Colors.white24,
                          ),
                        ),
                        Obx(
                          () => ListTile(
                            title: const Text(
                              'وقت التذكير اليومي',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Tajawal',
                              ),
                            ),
                            subtitle: Text(
                              _formatTime(
                                controller.quranHour.value,
                                controller.quranMinute.value,
                              ),
                              style: TextStyle(
                                color: AppTheme.secondaryColor,
                                fontFamily: 'Tajawal',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: const Icon(
                              Icons.schedule_rounded,
                              color: AppTheme.secondaryColor,
                            ),
                            onTap: () => _pickQuranTime(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  _sectionTitle('تحديد الموقع'),
                  _card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Obx(
                          () => SegmentedButton<bool>(
                            segments: const [
                              ButtonSegment<bool>(
                                value: true,
                                label: Text(
                                  'أونلاين',
                                  style: TextStyle(fontFamily: 'Tajawal'),
                                ),
                                icon: Icon(Icons.gps_fixed_rounded, size: 18),
                              ),
                              ButtonSegment<bool>(
                                value: false,
                                label: Text(
                                  'يدوي',
                                  style: TextStyle(fontFamily: 'Tajawal'),
                                ),
                                icon: Icon(Icons.edit_location_alt_rounded, size: 18),
                              ),
                            ],
                            selected: {controller.locationOnline.value},
                            onSelectionChanged: (s) {
                              controller.setLocationOnline(s.first);
                            },
                            style: ButtonStyle(
                              foregroundColor: WidgetStateProperty.resolveWith(
                                (states) {
                                  if (states.contains(WidgetState.selected)) {
                                    return AppTheme.backgroundColor;
                                  }
                                  return Colors.white70;
                                },
                              ),
                              backgroundColor: WidgetStateProperty.resolveWith(
                                (states) {
                                  if (states.contains(WidgetState.selected)) {
                                    return AppTheme.secondaryColor;
                                  }
                                  return Colors.white10;
                                },
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Obx(
                          () => controller.locationOnline.value
                              ? Text(
                                  'يُستخدم GPS والشبكة لتحديد المدينة ومواقيت الصلاة.',
                                  style: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.7),
                                    fontSize: 13,
                                    height: 1.4,
                                    fontFamily: 'Tajawal',
                                  ),
                                  textAlign: TextAlign.right,
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      'أدخل الإحداثيات (خط العرض، خط الطول) لمنطقتك.',
                                      style: TextStyle(
                                        color: Colors.white.withValues(alpha: 0.7),
                                        fontSize: 13,
                                        height: 1.4,
                                        fontFamily: 'Tajawal',
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                    const SizedBox(height: 12),
                                    _textField(
                                      controller: controller.manualLatController,
                                      label: 'خط العرض (Latitude)',
                                      keyboardType: const TextInputType.numberWithOptions(
                                        decimal: true,
                                        signed: true,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    _textField(
                                      controller: controller.manualLonController,
                                      label: 'خط الطول (Longitude)',
                                      keyboardType: const TextInputType.numberWithOptions(
                                        decimal: true,
                                        signed: true,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    _textField(
                                      controller: controller.manualLabelController,
                                      label: 'اسم المكان (اختياري)',
                                    ),
                                    const SizedBox(height: 14),
                                    FilledButton(
                                      onPressed: () =>
                                          controller.saveManualLocation(),
                                      style: FilledButton.styleFrom(
                                        backgroundColor: AppTheme.primaryColor,
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 14,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(14),
                                        ),
                                      ),
                                      child: const Text(
                                        'حفظ الموقع اليدوي',
                                        style: TextStyle(
                                          fontFamily: 'Tajawal',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ],
                    ),
                  ),
                  if (!kIsWeb &&
                      defaultTargetPlatform == TargetPlatform.android) ...[
                    const SizedBox(height: 24),
                    _sectionTitle('التطبيقات المصغرة'),
                    _card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'أضف بطاقة التقويم أو مواقيت الصلاة على الشاشة الرئيسية لمشاهدتها دون فتح التطبيق. يُفضّل فتح صفحة المواقيت مرة بعد التثبيت لتحديث البيانات.',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.72),
                              fontSize: 13,
                              height: 1.45,
                              fontFamily: 'Tajawal',
                            ),
                            textAlign: TextAlign.right,
                          ),
                          const SizedBox(height: 8),
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(
                              Icons.calendar_month_rounded,
                              color: AppTheme.secondaryColor,
                            ),
                            title: const Text(
                              'إضافة ويدجت التقويم',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Tajawal',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Text(
                              'هجري، ميلادي، مرحلة القمر',
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.6),
                                fontSize: 12,
                                fontFamily: 'Tajawal',
                              ),
                            ),
                            trailing: const Icon(
                              Icons.add_circle_outline_rounded,
                              color: Colors.white54,
                            ),
                            onTap: controller.requestPinCalendarHomeWidget,
                          ),
                          const Divider(height: 1, color: Colors.white12),
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(
                              Icons.schedule_rounded,
                              color: AppTheme.secondaryColor,
                            ),
                            title: const Text(
                              'إضافة ويدجت مواقيت الصلاة',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Tajawal',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Text(
                              'أوقات صلوات اليوم والموقع',
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.6),
                                fontSize: 12,
                                fontFamily: 'Tajawal',
                              ),
                            ),
                            trailing: const Icon(
                              Icons.add_circle_outline_rounded,
                              color: Colors.white54,
                            ),
                            onTap: controller.requestPinPrayerTimesHomeWidget,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton.icon(
                              onPressed:
                                  controller.showHomeWidgetManualInstructions,
                              icon: const Icon(
                                Icons.help_outline_rounded,
                                size: 20,
                                color: AppTheme.secondaryColor,
                              ),
                              label: const Text(
                                'كيف أضيفها يدوياً؟',
                                style: TextStyle(
                                  fontFamily: 'Tajawal',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              style: TextButton.styleFrom(
                                foregroundColor: AppTheme.secondaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                  _sectionTitle('معلومات المطور'),
                  FutureBuilder<PackageInfo>(
                    future: PackageInfo.fromPlatform(),
                    builder: (context, snap) {
                      final v = snap.data;
                      return _card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (v != null) ...[
                              _infoRow('اسم التطبيق', v.appName),
                              _infoRow('الإصدار', '${v.version} (${v.buildNumber})'),
                            ] else
                              const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(16),
                                  child: CircularProgressIndicator(
                                    color: AppTheme.secondaryColor,
                                  ),
                                ),
                              ),
                            const SizedBox(height: 8),
                            Text(
                              'أذكار المسلم — تطبيق إسلامي للأذكار، القرآن، المواقيت، والمزيد. للاقتراحات أو الدعم:',
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.75),
                                fontSize: 13,
                                height: 1.5,
                                fontFamily: 'Tajawal',
                              ),
                              textAlign: TextAlign.right,
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton.icon(
                                onPressed: UrlLauncherHelper.openWhatsApp,
                                icon: const Icon(Icons.chat_rounded, color: Color(0xFF25D366)),
                                label: const Text(
                                  'تواصل عبر واتساب',
                                  style: TextStyle(
                                    fontFamily: 'Tajawal',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  side: const BorderSide(color: Color(0xFF25D366)),
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickQuranTime(BuildContext context) async {
    final initial = TimeOfDay(
      hour: controller.quranHour.value,
      minute: controller.quranMinute.value,
    );
    final picked = await showTimePicker(
      context: context,
      initialTime: initial,
      builder: (ctx, child) {
        return Theme(
          data: Theme.of(ctx).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppTheme.secondaryColor,
              surface: AppTheme.surfaceColor,
            ),
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
    if (picked != null) {
      await controller.saveQuranReminderTime(picked.hour, picked.minute);
    }
  }

  static String _formatTime(int h, int m) {
    final period = h < 12 ? 'ص' : 'م';
    final hour12 = h % 12 == 0 ? 12 : h % 12;
    final mm = m.toString().padLeft(2, '0');
    return '$hour12:$mm $period';
  }

  static Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, right: 4),
      child: Text(
        title,
        style: const TextStyle(
          color: AppTheme.secondaryColor,
          fontSize: 15,
          fontWeight: FontWeight.bold,
          fontFamily: 'Tajawal',
        ),
        textAlign: TextAlign.right,
      ),
    );
  }

  static Widget _card({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
      ),
      child: child,
    );
  }

  static Widget _textField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.white, fontFamily: 'Tajawal'),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.white.withValues(alpha: 0.65),
          fontFamily: 'Tajawal',
        ),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.06),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.15)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppTheme.secondaryColor),
        ),
      ),
    );
  }

  static Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.55),
                fontSize: 13,
                fontFamily: 'Tajawal',
              ),
              textAlign: TextAlign.right,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: 'Tajawal',
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
