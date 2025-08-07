// lib/widgets/cards/tip_card.dart

import 'package:flutter/material.dart';
import 'package:taiz_water_tracker/config/colors.dart';
import 'package:taiz_water_tracker/models/tip_model.dart';

// ويدجت مسؤول عن عرض نصيحة واحدة فقط
// يأخذ كائن 'TipModel' ويعرض بياناته
class TipCard extends StatelessWidget {
  final TipModel tip;

  const TipCard({
    super.key,
    required this.tip,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        // أيقونة في بداية البطاقة
        leading: const Icon(
          Icons.lightbulb_outline,
          color: AppColors.accent,
          size: 30,
        ),
        // عنوان النصيحة
        title: Text(
          tip.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        // وصف النصيحة
        subtitle: Text(
          tip.description,
          style: TextStyle(color: Colors.grey[700]),
        ),
      ),
    );
  }
}
