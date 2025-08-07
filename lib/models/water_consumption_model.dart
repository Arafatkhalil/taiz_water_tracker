// lib/models/water_consumption_model.dart

// يمثل هذا المودل سجل استهلاك واحد للمياه
class WaterConsumptionModel {
  final int?
      id; // معرّف فريد للسجل في قاعدة البيانات، يكون فارغًا للسجلات الجديدة
  final double amount; // كمية المياه المستهلكة باللتر
  final DateTime date; // تاريخ ووقت تسجيل الاستهلاك
  final String category; // فئة الاستخدام (شرب، طبخ، نظافة، إلخ)

  WaterConsumptionModel({
    this.id,
    required this.amount,
    required this.date,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      // تخزين التاريخ كنص بصيغة ISO 8601 القياسية
      'date': date.toIso8601String(),
      'category': category,
    };
  }

  // دالة ثابتة لتحويل خريطة من قاعدة البيانات إلى كائن
  factory WaterConsumptionModel.fromMap(Map<String, dynamic> map) {
    return WaterConsumptionModel(
      id: map['id'],
      amount: map['amount'],
      // تحويل النص المخزن مرة أخرى إلى كائن DateTime
      date: DateTime.parse(map['date']),
      category: map['category'],
    );
  }
}
