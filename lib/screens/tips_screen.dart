// lib/screens/tips_screen.dart
import 'package:flutter/material.dart';
import 'package:taiz_water_tracker/models/tip_model.dart';
import 'package:taiz_water_tracker/services/data_service.dart';
import 'package:taiz_water_tracker/widgets/cards/tip_card.dart';

class TipsScreen extends StatefulWidget {
  const TipsScreen({super.key});

  @override
  State<TipsScreen> createState() => _TipsScreenState();
}

class _TipsScreenState extends State<TipsScreen> {
  final DataService _dataService = DataService();
  final ScrollController _scrollController = ScrollController();

  final List<TipModel> _tips = [];
  int _currentPage = 1;
  bool _isLoading = true; // تم تغيير الحالة الأولية للتحميل
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _loadInitialTips();
    _scrollController.addListener(_onScroll);
  }

  Future<void> _loadInitialTips() async {
    final newTips = await _dataService.loadTipsPaginated(page: _currentPage);
    if (mounted) {
      setState(() {
        _tips.addAll(newTips);
        _isLoading = false;
      });
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels <
            _scrollController.position.maxScrollExtent - 100 ||
        _isLoading) {
      return;
    }
    if (_hasMore) {
      _loadMoreTips();
    }
  }

  Future<void> _loadMoreTips() async {
    if (mounted)
      setState(() {
        _isLoading = true;
      });
    _currentPage++;
    final newTips = await _dataService.loadTipsPaginated(page: _currentPage);
    if (mounted) {
      setState(() {
        if (newTips.isEmpty) {
          _hasMore = false;
        } else {
          _tips.addAll(newTips);
        }
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ❌ تم حذف الـ Scaffold والـ AppBar من هنا
    return _tips.isEmpty && _isLoading
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            controller: _scrollController,
            itemCount: _tips.length + (_hasMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == _tips.length) {
                return const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              return TipCard(tip: _tips[index]);
            },
          );
  }
}
