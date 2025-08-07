// lib/models/water_supplier_model.dart
class WaterSupplierModel {
  final int id;
  final String name;
  final String phone;
  final List<String> areas;

  WaterSupplierModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.areas,
  });

  factory WaterSupplierModel.fromJson(Map<String, dynamic> json) {
    return WaterSupplierModel(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      areas: List<String>.from(json['areas']),
    );
  }
}
