// lib/main.dart
import 'package:flutter/material.dart';
import 'package:taiz_water_tracker/config/colors.dart';
import 'package:taiz_water_tracker/config/strings.dart';
import 'package:taiz_water_tracker/screens/splash_screen.dart';
// استيراد حزمة الترجمة
import 'package:flutter_localizations/flutter_localizations.dart';

// لا حاجة لتعديل دالة main، فهي صحيحة كما هي
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appTitle,

      // --- الجزء الخاص بتفعيل اللغة العربية و RTL ---
      locale: const Locale('ar'),
      supportedLocales: const [
        Locale('ar', ''),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // --- نهاية الجزء الخاص باللغة ---

      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
        fontFamily: 'Cairo',
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textLight,
          centerTitle: true,
          elevation: 0,
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: AppColors.accent,
          primary: AppColors.primary,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
