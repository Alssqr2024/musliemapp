import 'package:flutter/material.dart';

/// يحدّ من تأثير «حجم الخط / عرض الشاشة» في إعدادات النظام حتى لا تتضخم
/// العناوين والتخطيط على بعض الأجهزة، مع الإبقاء على تكبير معقول لإمكانية الوصول.
MediaQueryData clampAppTextScale(MediaQueryData data) {
  return data.copyWith(
    textScaler: data.textScaler.clamp(
      minScaleFactor: 0.88,
      maxScaleFactor: 1.2,
    ),
  );
}
