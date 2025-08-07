// lib/services/data_service.dart
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:taiz_water_tracker/models/pump_schedule_model.dart';
import 'package:taiz_water_tracker/models/tip_model.dart';
import 'package:taiz_water_tracker/models/water_supplier_model.dart';

class DataService {
  List<TipModel>? _allTips;
  List<PumpScheduleModel>? _allSchedules;

  Future<List<TipModel>> loadTipsPaginated(
      {int page = 1, int limit = 8}) async {
    if (_allTips == null) {
      final String jsonString =
          await rootBundle.loadString('assets/data/tips.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonString);
      _allTips = (jsonMap['tips'] as List)
          .map((json) => TipModel.fromJson(json))
          .toList();
    }
    await Future.delayed(const Duration(milliseconds: 700));
    final startIndex = (page - 1) * limit;
    if (startIndex >= _allTips!.length) return [];
    int endIndex = (startIndex + limit > _allTips!.length)
        ? _allTips!.length
        : startIndex + limit;
    return _allTips!.sublist(startIndex, endIndex);
  }

  Future<List<PumpScheduleModel>> loadSchedules() async {
    if (_allSchedules != null) return _allSchedules!;
    final String jsonString =
        await rootBundle.loadString('assets/data/neighborhoods.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    _allSchedules = (jsonMap['neighborhoods'] as List)
        .map((json) => PumpScheduleModel.fromJson(json))
        .toList();
    return _allSchedules!;
  }

  Future<List<WaterSupplierModel>> loadSuppliers() async {
    final String jsonString =
        await rootBundle.loadString('assets/data/water_suppliers.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    final List<dynamic> suppliersJson = jsonMap['suppliers'];
    return suppliersJson
        .map((json) => WaterSupplierModel.fromJson(json))
        .toList();
  }
}
