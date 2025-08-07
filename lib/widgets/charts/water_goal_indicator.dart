// lib/widgets/charts/water_goal_indicator.dart
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:taiz_water_tracker/config/colors.dart';

// ويدجت احترافي لعرض هدف الماء اليومي على شكل مؤشر دائري متحرك
class WaterGoalIndicator extends StatelessWidget {
  final double currentConsumption;
  final double dailyGoal;

  const WaterGoalIndicator({
    super.key,
    required this.currentConsumption,
    required this.dailyGoal,
  });

  @override
  Widget build(BuildContext context) {
    // حساب نسبة الإنجاز
    final double progress =
        (dailyGoal == 0) ? 0 : currentConsumption / dailyGoal;

    // استخدام هذا الويدجت الرائع لعمل الأنيميشن بسلاسة من قيمة بداية إلى نهاية
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: progress),
      duration: const Duration(seconds: 2), // مدة الأنيميشن
      curve: Curves.easeInOutCubic, // نوع الحركة لمظهر طبيعي
      builder: (context, value, child) {
        return SizedBox(
          width: 150,
          height: 150,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // الدائرة الخلفية التي تمثل المسار الكامل
              CircularProgressIndicator(
                value: 1,
                strokeWidth: 12,
                backgroundColor: AppColors.primary.withOpacity(0.2),
                color: AppColors.primary,
              ),
              // الدائرة الأمامية التي تمثل التقدم الفعلي
              CircularProgressIndicator(
                value: value,
                strokeWidth: 12,
                backgroundColor: Colors.transparent,
                color: AppColors.secondary,
              ),
              // النص في المنتصف لعرض النسبة
              Center(
                child: Text(
                  '${(value * 100).toInt()}%',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
