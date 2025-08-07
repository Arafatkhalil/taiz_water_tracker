// lib/widgets/cards/consumption_card.dart
import 'package:flutter/material.dart';
import 'package:taiz_water_tracker/config/colors.dart';

class ConsumptionCard extends StatelessWidget {
  final double amount;

  const ConsumptionCard({
    super.key,
    required this.amount, // جعلناه مطلوباً
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'استهلاك اليوم',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.water_drop_outlined,
                  color: AppColors.primary,
                  size: 40,
                ),
                // ✅ عرض الكمية الفعلية مع تنسيقها
                Text(
                  '${amount.toStringAsFixed(1)} لتر',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
