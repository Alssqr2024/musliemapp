# قائمة جاهزية النشر على المتجر

## ✅ ما تم (جاهز)

| البند | الحالة |
|--------|--------|
| **الإصدار** | `1.0.0+1` في pubspec.yaml |
| **معرّف التطبيق (Android)** | `com.alssqr.musliemapp` (مناسب للنشر) |
| **اسم التطبيق للمستخدم** | "أذكار المسلم" في Android |
| **إخفاء شريط التطوير** | `debugShowCheckedModeBanner: false` |
| **معالجة الأخطاء** | تحميل JSON آمن، تسجيل أخطاء عبر LoggerService |
| **رقم واتساب المطور** | مُعرّف في الكود (تأكد من صحته) |
| **الأذونات** | مُعلنة في AndroidManifest (موقع، إشعارات، تنبيهات دقيقة) |

---

## ⚠️ مطلوب قبل النشر

### 1. توقيع التطبيق (Release signing) — Android

حالياً نسخة الـ release تُوقّع بمفتاح التطوير (debug). للنشر على Google Play يجب:

1. إنشاء keystore (مرة واحدة):
   ```bash
   keytool -genkey -v -keystore upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
   ```
2. إنشاء الملف `android/key.properties` (لا تضعه في Git):
   ```properties
   storePassword=***
   keyPassword=***
   keyAlias=upload
   storeFile=../upload-keystore.jks
   ```
3. تعديل `android/app/build.gradle.kts` لاستخدام توقيع الـ release عند البناء.

[الشرح الرسمي: توقيع التطبيق لـ Android](https://docs.flutter.dev/deployment/android#signing-the-app)

---

### 2. سياسة الخصوصية (Privacy Policy)

متاجر التطبيقات تطلب رابط **سياسة خصوصية** إذا كان التطبيق يجمع بيانات (مثل الموقع).

- التطبيق يستخدم **الموقع** لمواقيت الصلاة و**الإشعارات**.
- يُفضّل نشر صفحة ويب تحتوي على: ما هي البيانات المستخدمة (موقع، معرف الجهاز إن وُجد)، كيف تُستخدم، وأنك لا تبيع البيانات.
- أضف الرابط في:
  - **Google Play Console** → صفحة التطبيق → سياسة الخصوصية
  - **Apple App Store Connect** → معلومات التطبيق → رابط سياسة الخصوصية (إن نشرت على iOS)

---

### 3. أصول المتجر (لا تُرفع تلقائياً من المشروع)

- **أيقونة التطبيق**: تأكد أن `android/app/src/main/res/` تحتوي أيقونة مناسبة بجميع الأحجام.
- **لقطات شاشة**: التقط صوراً للواجهة (هاتف 6.5"، لوحي إن أردت) وأضفها في Console.
- **وصف قصير وطويل** بالعربية (والإنجليزية إن أردت).
- **تصنيف المحتوى**: اختر العمر المناسب (غالباً للجميع).

---

### 4. بناء نسخة النشر

```bash
# Android (APK للاختبار أو AAB للنشر)
flutter build appbundle

# الملف الناتج: build/app/outputs/bundle/release/app-release.aab
# ارفعه في Google Play Console → الإنتاج → إنشاء إصدار جديد
```

```bash
# iOS (إن كنت ستنشر على Apple)
flutter build ios
# ثم من Xcode: Product → Archive → Distribute App
```

---

### 5. اختبار نهائي

- [ ] تشغيل التطبيق في وضع **Release** على جهاز حقيقي: `flutter run --release`
- [ ] التأكد من عمل: مواقيت الصلاة، الإشعارات، واتساب، كل الشاشات الرئيسية
- [ ] التأكد من عدم ظهور أي رسائل تطوير أو روابط تجريبية

---

## iOS (إن أردت النشر على App Store)

- إعداد **Apple Developer Account** (مدفوع).
- في Xcode: تعيين **Team** و **Bundle Identifier** (مثلاً `com.alssqr.musliemapp`).
- إضافة **سياسة الخصوصية** ووصف التطبيق في App Store Connect.
- بناء أرشيف (Archive) ورفعه عبر Xcode أو Transporter.

---

## ملخص

| البند | الحالة |
|--------|--------|
| كود وجاهزية تقنية للنشر | ✅ جاهز |
| توقيع Release (Android) | ⚠️ مطلوب منك |
| سياسة الخصوصية ورابطها | ⚠️ مطلوب منك |
| أصول المتجر (صور، وصف) | ⚠️ مطلوب منك |
| بناء AAB ورفع على Play Console | ⚠️ بعد إعداد التوقيع والحساب |

بعد إعداد التوقيع وسياسة الخصوصية وأصول المتجر، يمكنك اعتبار التطبيق **جاهزاً للنشر** على المتجر من ناحية المشروع.
