// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:taiz_water_tracker/screens/statistics_screen.dart';
import 'package:taiz_water_tracker/services/settings_service.dart';
import 'package:taiz_water_tracker/services/storage_service.dart';
import 'package:taiz_water_tracker/widgets/cards/consumption_card.dart';
import 'package:taiz_water_tracker/widgets/charts/water_goal_indicator.dart';
import 'package:taiz_water_tracker/widgets/common/credit_marquee.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _settingsService = SettingsService();
  double _todaysConsumption = 0.0;
  double _dailyGoal = 200.0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    if (!mounted) return;
    setState(() { _isLoading = true; });
    
    final results = await Future.wait([
      StorageService.instance.getTodaysTotalConsumption(),
      _settingsService.loadDailyGoal(),
    ]);
    
    if (mounted) {
      setState(() {
        _todaysConsumption = results[0];
        _dailyGoal = results[1];
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : Column(
            children: [
              const CreditMarquee(),
              
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround, // توزيع المساحات بشكل متساوٍ
                    children: [
                      // --- الجزء العلوي ---
                      ConsumptionCard(amount: _todaysConsumption),

                      // --- الجزء الأوسط ---
                      Column(
                        children: [
                          const Text('هدف اليوم', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 20),
                          WaterGoalIndicator(
                            currentConsumption: _todaysConsumption,
                            dailyGoal: _dailyGoal,
                          ),
                        ],
                      ),
                      
                      // --- الجزء السفلي ---
                      Center(
                        child: TextButton.icon(
                          icon: const Icon(Icons.bar_chart),
                          label: const Text('عرض الإحصائيات التفصيلية'),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => const StatisticsScreen()),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
  }
}