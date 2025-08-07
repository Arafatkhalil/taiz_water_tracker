// lib/widgets/common/custom_app_bar.dart

import 'package:flutter/material.dart';
import 'package:taiz_water_tracker/config/colors.dart';

// هذا الكلاس الاحترافي يقوم بإنشاء شريط عنوان (AppBar) مخصص
// استخدامه يضمن أن كل شاشات التطبيق لها نفس الشكل والمظهر
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // عنوان الشريط الذي نمرره من كل شاشة
      title: Text(title),
      // لوضع العنوان في المنتصف
      centerTitle: true,
      // درجة الظل تحت الشريط، صفر يعني بدون ظل لمظهر أنظف
      elevation: 0,
      // لون الخلفية من ملف الألوان الموحد
      backgroundColor: AppColors.primary,
      // لون النص والأيقونات من ملف الألوان الموحد
      foregroundColor: AppColors.textLight,
    );
  }

  

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}