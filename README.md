# 🚰 Taiz Water Tracker | متتبع مياه تعز

<div align="center">
  <img src="assets/images/app_icon.png" alt="App Icon" width="100" height="100">
  <h3>تطبيق ذكي لتتبع وإدارة استهلاك المياه في مدينة تعز</h3>
  <p>Smart Water Consumption and Schedule Tracking App for Taiz City</p>
</div>

## 📱 حول التطبيق | About the App

**العربية:**
تطبيق متتبع مياه تعز هو حل ذكي ومبتكر لمساعدة سكان مدينة تعز على تتبع وإدارة استهلاك المياه بشكل فعال. يوفر التطبيق مجموعة شاملة من الميزات لمتابعة جداول ضخ المياه، تسجيل الاستهلاك اليومي، وعرض إحصائيات مفصلة لمساعدة المستخدمين على تحسين استخدامهم للمياه.

**English:**
Taiz Water Tracker is an innovative and smart solution designed to help residents of Taiz city effectively track and manage their water consumption. The app provides a comprehensive set of features for monitoring water pumping schedules, recording daily consumption, and displaying detailed statistics to help users optimize their water usage.

## ✨ الميزات الرئيسية | Key Features

### 🏠 الشاشة الرئيسية | Home Screen
- عرض سريع لحالة المياه الحالية
- إحصائيات الاستهلاك اليومي والأسبوعي
- تنبيهات مواعيد الضخ القادمة

### 📊 تتبع الاستهلاك | Consumption Tracking
- تسجيل الاستهلاك اليومي للمياه
- حفظ البيانات محلياً باستخدام SQLite
- عرض تاريخ الاستهلاك السابق

### ⏰ جدولة المياه | Water Scheduling
- إدارة جداول ضخ المياه
- تنبيهات ذكية لمواعيد الضخ
- تخصيص أوقات التنبيهات

### 📈 الإحصائيات والتحليلات | Statistics & Analytics
- رسوم بيانية تفاعلية باستخدام FL Chart
- تحليل أنماط الاستهلاك
- مقارنات شهرية وأسبوعية

### 🏢 معلومات الموردين | Suppliers Information
- قائمة بموردي المياه في تعز
- معلومات الاتصال والمواقع
- تقييمات وملاحظات المستخدمين

### 💡 نصائح توفير المياه | Water Saving Tips
- نصائح يومية لتوفير المياه
- إرشادات للاستخدام الأمثل
- معلومات تثقيفية حول أهمية المياه

### ⚙️ الإعدادات | Settings
- تخصيص التنبيهات
- إعدادات اللغة والمظهر
- إدارة البيانات الشخصية

## 🛠️ التقنيات المستخدمة | Technologies Used

### Frontend
- **Flutter** - إطار العمل الرئيسي
- **Dart** - لغة البرمجة
- **Material Design** - تصميم واجهة المستخدم

### Database & Storage
- **SQLite** - قاعدة البيانات المحلية
- **SharedPreferences** - تخزين الإعدادات
- **Path Provider** - إدارة مسارات الملفات

### Charts & Visualization
- **FL Chart** - الرسوم البيانية التفاعلية
- **Custom Widgets** - عناصر واجهة مخصصة

### Notifications & Scheduling
- **Flutter Local Notifications** - التنبيهات المحلية
- **Background Tasks** - المهام الخلفية

### Localization & Internationalization
- **Flutter Localizations** - دعم اللغة العربية
- **RTL Support** - دعم الكتابة من اليمين لليسار
- **Intl Package** - تنسيق التواريخ والأرقام

### Additional Features
- **HTTP** - طلبات الشبكة
- **URL Launcher** - فتح الروابط الخارجية
- **Marquee** - النصوص المتحركة

## 📁 هيكل المشروع | Project Structure

```
lib/
├── config/          # إعدادات التطبيق والألوان والنصوص
├── models/          # نماذج البيانات
├── screens/         # شاشات التطبيق
├── services/        # خدمات قاعدة البيانات والتنبيهات
├── utils/           # أدوات مساعدة
├── widgets/         # عناصر واجهة مخصصة
└── main.dart        # نقطة بداية التطبيق
```

## 🚀 التثبيت والتشغيل | Installation & Setup

### المتطلبات | Prerequisites
- Flutter SDK (>=3.2.3)
- Dart SDK
- Android Studio / VS Code
- Android/iOS Emulator or Physical Device

### خطوات التثبيت | Installation Steps

1. **استنساخ المشروع | Clone the Repository**
```bash
git clone https://github.com/ArafatKhalil/taiz_water_tracker.git
cd taiz_water_tracker
```

2. **تثبيت التبعيات | Install Dependencies**
```bash
flutter pub get
```

3. **تشغيل التطبيق | Run the App**
```bash
flutter run
```

## 📱 لقطات الشاشة | Screenshots

*سيتم إضافة لقطات الشاشة قريباً*

## 🤝 المساهمة | Contributing

نرحب بمساهماتكم لتطوير التطبيق! يرجى اتباع الخطوات التالية:

1. Fork المشروع
2. إنشاء فرع جديد (`git checkout -b feature/AmazingFeature`)
3. Commit التغييرات (`git commit -m 'Add some AmazingFeature'`)
4. Push للفرع (`git push origin feature/AmazingFeature`)
5. فتح Pull Request

## 📄 الترخيص | License

هذا المشروع مرخص تحت رخصة MIT - راجع ملف [LICENSE](LICENSE) للتفاصيل.

## 📞 التواصل | Contact

**المطور | Developer:** Arafat Khalil  
**البريد الإلكتروني | Email:** arafatt2023@gmail.com  
**GitHub:** [@ArafatKhalil](https://github.com/ArafatKhalil)

## 🙏 شكر وتقدير | Acknowledgments

- شكر خاص لمجتمع Flutter للدعم والموارد الممتازة
- تقدير لسكان تعز الذين ألهموا فكرة هذا التطبيق
- امتنان للمساهمين في تطوير وتحسين التطبيق

---

<div align="center">
  <p>صُنع بـ ❤️ في اليمن | Made with ❤️ in Yemen</p>
  <p>لمدينة تعز الحبيبة | For the beloved city of Taiz</p>
</div>
