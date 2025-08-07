// lib/screens/main_screen.dart

import 'package:flutter/material.dart';
import 'package:taiz_water_tracker/config/colors.dart';
import 'package:taiz_water_tracker/config/strings.dart';
import 'package:taiz_water_tracker/screens/consumption_screen.dart';
import 'package:taiz_water_tracker/screens/home_screen.dart';
import 'package:taiz_water_tracker/screens/profile_screen.dart';
import 'package:taiz_water_tracker/screens/schedule_screen.dart';
import 'package:taiz_water_tracker/screens/settings_screen.dart';
import 'package:taiz_water_tracker/screens/suppliers_screen.dart';
import 'package:taiz_water_tracker/screens/tips_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pageContent = const <Widget>[
    HomeScreen(),
    ScheduleScreen(),
    TipsScreen(),
    SuppliersScreen(),
  ];

  final List<String> _pageTitles = const <String>[
    AppStrings.homeScreenTitle,
    AppStrings.scheduleScreenTitle,
    AppStrings.tipsScreenTitle,
    'دليل الوايتات',
  ];

  void _onItemTapped(int index) {
    if (Scaffold.of(context).isDrawerOpen) {
      Navigator.of(context).pop();
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pageTitles[_selectedIndex]),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'الإعدادات',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
          Hero(
            tag: 'profile-avatar',
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const ProfileScreen()),
                  );
                },
                child: const CircleAvatar(
                  radius: 18, 
                  backgroundImage: AssetImage(
                      'assets/images/profile.png'), 
                ),
                // --- نهاية التعديل ---
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(color: AppColors.primary),
              child: Text(AppStrings.appTitle,
                  style: const TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('الرئيسية'),
              selected: _selectedIndex == 0,
              onTap: () => _onItemTapped(0),
            ),
            ListTile(
              leading: const Icon(Icons.schedule),
              title: const Text('الجدول'),
              selected: _selectedIndex == 1,
              onTap: () => _onItemTapped(1),
            ),
            ListTile(
              leading: const Icon(Icons.lightbulb),
              title: const Text('نصائح'),
              selected: _selectedIndex == 2,
              onTap: () => _onItemTapped(2),
            ),
            ListTile(
              leading: const Icon(Icons.local_shipping),
              title: const Text('الوايتات'),
              selected: _selectedIndex == 3,
              onTap: () => _onItemTapped(3),
            ),
          ],
        ),
      ),
      body: _pageContent.elementAt(_selectedIndex),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const ConsumptionScreen()),
          );
        },
        shape: const CircleBorder(),
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        color: Colors.white,
        elevation: 8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildNavIcon(icon: Icons.home_filled, label: 'الرئيسية', index: 0),
            _buildNavIcon(icon: Icons.schedule, label: 'الجدول', index: 1),
            _buildNavIcon(icon: Icons.lightbulb, label: 'نصائح', index: 2),
            _buildNavIcon(
                icon: Icons.local_shipping, label: 'الوايتات', index: 3),
          ],
        ),
      ),
    );
  }

  Widget _buildNavIcon(
      {required IconData icon, required String label, required int index}) {
    final bool isSelected = _selectedIndex == index;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      borderRadius: BorderRadius.circular(30),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: isSelected ? AppColors.primary : Colors.grey),
            const SizedBox(height: 4),
            Text(label,
                style: TextStyle(
                    color: isSelected ? AppColors.primary : Colors.grey,
                    fontSize: 12,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal)),
          ],
        ),
      ),
    );
  }
}
