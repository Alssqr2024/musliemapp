# MusliemApp 🌙 | تطبيق أذكار المسلم النخبوي

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)
![GetX](https://img.shields.io/badge/GetX-%23E91E63.svg?style=for-the-badge&logo=flutter&logoColor=white)
![Aesthetics](https://img.shields.io/badge/Design-Glassmorphism-gold?style=for-the-badge)

**Experience Spirituality with Premium Zen Design & Unmatched Performance.**
*تجربة روحانية تجمع بين التصميم النخبوي والأداء الفائق.*

[English Overview](#-english-description) | [الوصف العربي](#-وصف-المشروع)

</div>

---

## 🇬🇧 English Description

### 🌟 Premium Features

*   **✨ Glassmorphism "Zen" UI**: A modern, translucent interface designed to reduce digital noise and focus on spiritual content.
*   **🕌 Smart Prayer Timings**: Precise calculations with a focus on GPS accuracy and a beautifully designed "Bento Box" countdown card.
*   **🔔 Custom Audio Alerts**: High-quality MP3 notification sound (*"Hana Al-An Waqt Al-Salah"*) integrated directly into Android system resources.
*   **📖 Comprehensive Encyclopedia**:
    *   **Hadith**: Qudsi, Nawawi (42), and Shamail Muhammadiyah.
    *   **Azkar**: Dynamic daily Morning & Evening rotation.
    *   **99 Names of Allah**: High-resolution visual gallery.
*   **🚀 Extreme Performance**: Optimized for 0% redundant rebuilds (1s header timer isolation) and minimal battery drain.

### 🛠️ Technical Prowess

*   **Architecture**: GetX (State, Dependency, Route Management).
*   **Audio Engineering**: Custom native Android resource integration for reliable notification sounds.
*   **Theming**: Royal Emerald color palette with custom **Tajawal** typography.
*   **Performance**: Isolated `Obx` scopes and widespread `const` usage for buttery-smooth 60fps scrolling.

---

## 🇸🇦 وصف المشروع (Arabic)

### 🌟 المميزات النخبوية

*   **✨ واجهة Zen الزجاجية**: تصميم عصري يعتمد على نظام Glassmorphism لتقليل التشتت البصري والتركيز على المحتوى الروحاني.
*   **🕌 مواقيت الصلاة الذكية**: حسابات دقيقة تعتمد على الموقع الجغرافي (GPS) مع واجهة "بينتو" (Bento Box) تعرض الوقت المتبقي بأناقة.
*   **🔔 تنبيهات صوتية مخصصة**: نغمة تنبيه عالية الجودة ("حان الآن وقت الصلاة") مدمجة مباشرة في موارد النظام لضمان التنبيه في وقته.
*   **📖 مكتبة شاملة**:
    *   **الأحاديث**: الأربعون النووية، القدسية، والشمائل المحمدية مع عناوين منسقة.
    *   **الأذكار**: تدوير ذكي للأذكار اليومية (الصباح والمساء) في الواجهة الرئيسية.
    *   **أسماء الله الحسنى**: معرض بصري بدقة عالية لـ 99 اسماً.
*   **🚀 أداء فائق وسرعة**: تحسين شامل للكود لتقليل استهلاك البطارية والرامات (تقليص نطاق التحديث المستمر للعداد).

---

### 📱 Preview / المعاينة

| Home Page | Services Hub | Calendar Card |
|:---:|:---:|:---:|
| ![Home](https://via.placeholder.com/200x400?text=Zen+Home) | ![Services](https://via.placeholder.com/200x400?text=Services+Hub) | ![Calendar](https://via.placeholder.com/200x400?text=Glass+Calendar) |

---

### 📂 Project Architecture / هيكلية النظام

```
lib/
├── core/            # Theme, Notification Service, Initial Bindings
├── features/        # Business Logic & Pages (Azkar, Hadith, Prayer, etc.)
├── utils/           # Shared Glass Widgets & Global Constants
└── main.dart        # Optimized Entry Point (Notification Init & GetX Setup)
```

### 🚀 Developer Setup

1.  **Clone**: `git clone https://github.com/alssqr/musliemapp.git`
2.  **Dependencies**: `flutter pub get`
3.  **Run**: `flutter run` (Use release mode for best glassmorphism performance)

---

<p align="center">
  <b>MusliemApp - Developed for a Premium Spiritual Experience</b><br>
  <i>Designed & Optimized by Antigravity AI</i>
</p>
