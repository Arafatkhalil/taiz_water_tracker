// lib/screens/schedule_screen.dart
import 'package:flutter/material.dart';
import 'package:taiz_water_tracker/models/pump_schedule_model.dart';
import 'package:taiz_water_tracker/services/data_service.dart';
import 'package:taiz_water_tracker/widgets/animations/list_item_animator.dart';
import 'package:taiz_water_tracker/widgets/cards/schedule_card.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  final DataService _dataService = DataService();
  final TextEditingController _searchController = TextEditingController();

  List<PumpScheduleModel> _allSchedules = [];
  List<PumpScheduleModel> _filteredSchedules = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
    _searchController.addListener(_filterSchedules);
  }

  Future<void> _loadData() async {
    if (mounted)
      setState(() {
        _isLoading = true;
      });
    final schedules = await _dataService.loadSchedules();
    if (mounted) {
      setState(() {
        _allSchedules = schedules;
        _filteredSchedules = schedules;
        _isLoading = false;
      });
    }
  }

  void _filterSchedules() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredSchedules = _allSchedules.where((schedule) {
        return schedule.name.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // -- شريط البحث --
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'ابحث عن حيك...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
        // -- قائمة النتائج --
        Expanded(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _filteredSchedules.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      itemCount: _filteredSchedules.length,
                      itemBuilder: (context, index) {
                        return ListItemAnimator(
                          child:
                              ScheduleCard(schedule: _filteredSchedules[index]),
                        );
                      },
                    ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'لا توجد نتائج مطابقة لبحثك',
            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
