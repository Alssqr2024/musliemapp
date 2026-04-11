# ============================================================
# ProGuard Rules for MusliemApp
# ============================================================

# Flutter - Keep all Flutter engine classes
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }
-dontwarn io.flutter.**

# flutter_local_notifications - CRITICAL: Prevents notifications from breaking in release
-keep class com.dexterous.** { *; }
-keep class com.dexterous.flutterlocalnotifications.** { *; }
-dontwarn com.dexterous.**

# CRITICAL FIX: GSON TypeToken - prevents "Missing type parameter" crash
# flutter_local_notifications uses GSON TypeToken to save/load scheduled notifications.
# R8 strips the generic type info from anonymous TypeToken subclasses. This keeps it intact.
-keep class com.google.gson.reflect.TypeToken { *; }
-keep class * extends com.google.gson.reflect.TypeToken
-keepattributes Signature
-keepattributes *Annotation*

# timezone package - CRITICAL: Required for scheduled (zonedSchedule) notifications
-keep class com.google.protobuf.** { *; }
-keep class dev.fluttercommunity.plus.** { *; }
-keep class com.ryanheise.** { *; }

# Kotlin coroutines & serialization
-keepattributes *Annotation*
-keepattributes Signature
-keepattributes SourceFile,LineNumberTable

# Keep enums
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

# Geolocator - Ensure GPS services classes are not stripped
-keep class com.baseflow.geolocator.** { *; }
-dontwarn com.baseflow.geolocator.**

# android_intent_plus
-keep class dev.fluttercommunity.plus.androidintent.** { *; }
-dontwarn dev.fluttercommunity.plus.androidintent.**

# App widgets (home_widget) — لا يُزال مزوّد الويدجت أو كلاسات الربط في الإصدار الموقّع
-keep class com.alssqr.musliemapp.CalendarWidgetProvider { *; }
-keep class com.alssqr.musliemapp.PrayerTimesWidgetProvider { *; }
-keep class es.antonborri.home_widget.** { *; }
