// lib/screens/suppliers_screen.dart
import 'package:flutter/material.dart';
import 'package:taiz_water_tracker/models/water_supplier_model.dart';
import 'package:taiz_water_tracker/services/data_service.dart';
import 'package:taiz_water_tracker/widgets/cards/supplier_card.dart';

class SuppliersScreen extends StatefulWidget {
  const SuppliersScreen({super.key});
  @override
  State<SuppliersScreen> createState() => _SuppliersScreenState();
}

class _SuppliersScreenState extends State<SuppliersScreen> {
  final DataService _dataService = DataService();
  late Future<List<WaterSupplierModel>> _suppliersFuture;

  @override
  void initState() {
    super.initState();
    _suppliersFuture = _dataService.loadSuppliers();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<WaterSupplierModel>>(
      future: _suppliersFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text('حدث خطأ في تحميل البيانات'));
        }
        final suppliers = snapshot.data!;
        return ListView.builder(
          itemCount: suppliers.length,
          itemBuilder: (context, index) {
            return SupplierCard(supplier: suppliers[index]);
          },
        );
      },
    );
  }
}
