// lib/services/settings_service.dart
import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  // مفتاح ثابت لتخزين قيمة الهدف اليومي
  static const String _dailyGoalKey = 'daily_goal';
  // القيمة الافتراضية إذا لم يحدد المستخدم هدفًا بعد
  static const double _defaultGoal = 200.0;

  // دالة لحفظ الهدف اليومي الجديد
  Future<void> saveDailyGoal(double goal) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_dailyGoalKey, goal);
  }

  // دالة لجلب الهدف اليومي المحفوظ
  Future<double> loadDailyGoal() async {
    final prefs = await SharedPreferences.getInstance();
    // إذا لم يجد قيمة، سيعيد القيمة الافتراضية
    return prefs.getDouble(_dailyGoalKey) ?? _defaultGoal;
  }
}
