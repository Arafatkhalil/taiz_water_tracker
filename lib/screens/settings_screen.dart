// lib/screens/settings_screen.dart
import 'package:flutter/material.dart';
import 'package:taiz_water_tracker/config/colors.dart';
import 'package:taiz_water_tracker/services/settings_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _settingsService = SettingsService();
  final _goalController = TextEditingController();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final goal = await _settingsService.loadDailyGoal();
    if (mounted) {
      setState(() {
        _goalController.text = goal.toStringAsFixed(1);
        _isLoading = false;
      });
    }
  }

  Future<void> _saveSettings() async {
    final newGoal = double.tryParse(_goalController.text);
    if (newGoal != null && newGoal > 0) {
      await _settingsService.saveDailyGoal(newGoal);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم حفظ الإعدادات بنجاح!'),
          backgroundColor: AppColors.secondary,
        ),
      );
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('الرجاء إدخال قيمة صحيحة للهدف'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    _goalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // هذه الشاشة تحتاج Scaffold خاص بها
    return Scaffold(
      appBar: AppBar(title: const Text('الإعدادات')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                ListTile(
                  leading: const Icon(Icons.track_changes),
                  title: const Text('الهدف اليومي للاستهلاك (باللتر)'),
                  subtitle: TextFormField(
                    controller: _goalController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: '200.0',
                    ),
                  ),
                ),
                const Divider(height: 32),
                ElevatedButton(
                  onPressed: _saveSettings,
                  child: const Text('حفظ الإعدادات'),
                )
              ],
            ),
    );
  }
}
