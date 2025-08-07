// lib/screens/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:taiz_water_tracker/config/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الملف الشخصي'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ✅ هذا هو الويدجت الوجهة. لاحظ تطابق الـ tag
            Hero(
              tag: 'profile-avatar',
              child: CircleAvatar(
                radius: 80, // حجم أكبر
                // ✅ --- هذا هو السطر الذي تم تعديله لعرض الصورة ---
                backgroundImage: const AssetImage('assets/images/profile.png'),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'عرفات', 
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const Text(
              'مطور فلاتر',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
