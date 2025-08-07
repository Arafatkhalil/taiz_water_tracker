// lib/screens/statistics_screen.dart
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:taiz_water_tracker/config/colors.dart';
import 'package:taiz_water_tracker/services/storage_service.dart';
import 'package:taiz_water_tracker/widgets/common/custom_app_bar.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  final StorageService _storageService = StorageService.instance;
  late Future<Map<int, double>> _weeklyDataFuture;

  @override
  void initState() {
    super.initState();
    _weeklyDataFuture = _storageService.getWeeklyConsumption();
  }

  @override
  Widget build(BuildContext context) {
    // ✅ --- الحل هنا: إعادة الـ Scaffold والـ AppBar --- ✅
    return Scaffold(
      appBar: const CustomAppBar(title: 'إحصائيات الاستهلاك'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<Map<int, double>>(
          future: _weeklyDataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError ||
                !snapshot.hasData ||
                snapshot.data!.isEmpty) {
              return const Center(
                  child: Text('لا توجد بيانات كافية لعرض الإحصائيات'));
            }

            final weeklyData = snapshot.data!;
            final maxValue = weeklyData.values
                .fold(0.0, (prev, element) => element > prev ? element : prev);

            return BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: maxValue == 0.0
                    ? 100
                    : maxValue * 1.2, // تجنب الخطأ إذا كانت كل القيم صفر
                barTouchData: BarTouchData(enabled: true),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: _bottomTitles,
                          reservedSize: 28)),
                  leftTitles: AxisTitles(
                      sideTitles:
                          SideTitles(showTitles: true, reservedSize: 40)),
                  topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                ),
                gridData: const FlGridData(show: true, drawVerticalLine: false),
                borderData: FlBorderData(show: false),
                barGroups: _generateBarGroups(weeklyData),
              ),
            );
          },
        ),
      ),
    );
  }

  // ... بقية دوال الرسم البياني كما هي ...
  List<BarChartGroupData> _generateBarGroups(Map<int, double> data) {
    return List.generate(7, (index) {
      int dayIndex = (index + 1) % 7;
      return BarChartGroupData(x: index, barRods: [
        BarChartRodData(
            toY: data[dayIndex] ?? 0.0,
            color: AppColors.primary,
            width: 20,
            borderRadius: BorderRadius.circular(4))
      ]);
    });
  }

  Widget _bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(fontSize: 10);
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'إثنين';
        break;
      case 1:
        text = 'ثلاثاء';
        break;
      case 2:
        text = 'أربعاء';
        break;
      case 3:
        text = 'خميس';
        break;
      case 4:
        text = 'جمعة';
        break;
      case 5:
        text = 'سبت';
        break;
      case 6:
        text = 'أحد';
        break;
      default:
        text = '';
    }
    return SideTitleWidget(
        axisSide: meta.axisSide, space: 4, child: Text(text, style: style));
  }
}
