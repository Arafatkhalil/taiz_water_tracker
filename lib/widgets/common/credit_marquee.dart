// lib/widgets/common/credit_marquee.dart
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:taiz_water_tracker/config/colors.dart';

class CreditMarquee extends StatelessWidget {
  const CreditMarquee({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      color: AppColors.primary.withOpacity(0.8),
      child: Marquee(
        text: '       *** إشراف: م. أمجاد   *** عمل الطالب: عرفات   *** ',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        scrollAxis: Axis.horizontal,
        blankSpace: 20.0,
        velocity: 50.0, // سرعة الحركة
        pauseAfterRound: const Duration(seconds: 1),
        startPadding: 10.0,
        accelerationDuration: const Duration(seconds: 1),
        accelerationCurve: Curves.linear,
        decelerationDuration: const Duration(milliseconds: 500),
        decelerationCurve: Curves.easeOut,
      ),
    );
  }
}
