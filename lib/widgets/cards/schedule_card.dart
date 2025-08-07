// lib/widgets/cards/schedule_card.dart
import 'package:flutter/material.dart';
import 'package:taiz_water_tracker/config/colors.dart';
import 'package:taiz_water_tracker/models/pump_schedule_model.dart';

class ScheduleCard extends StatelessWidget {
  final PumpScheduleModel schedule;

  const ScheduleCard({super.key, required this.schedule});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // اسم الحي
            Text(
              schedule.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const Divider(height: 20),
            // قسم أيام الضخ
            _buildInfoRow(
              icon: Icons.calendar_today,
              title: 'الأيام:',
              children: schedule.pumpDays
                  .map((day) => Chip(label: Text(day)))
                  .toList(),
            ),
            const SizedBox(height: 10),
            // قسم أوقات الضخ
            _buildInfoRow(
              icon: Icons.access_time_filled,
              title: 'الأوقات:',
              children: schedule.pumpTimes
                  .map((time) => Chip(
                        label: Text(time),
                        backgroundColor: AppColors.secondary.withOpacity(0.2),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  // ويدجت مساعد لتنظيم عرض البيانات
  Widget _buildInfoRow(
      {required IconData icon,
      required String title,
      required List<Widget> children}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.grey[600], size: 20),
        const SizedBox(width: 8),
        Text(title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(width: 8),
        Expanded(
          child: Wrap(
            spacing: 8.0, // المسافة الأفقية بين العناصر
            runSpacing: 4.0, // المسافة العمودية بين الأسطر
            children: children,
          ),
        ),
      ],
    );
  }
}
