// lib/models/tip_model.dart

// هذا الكلاس يمثل بنية بيانات النصيحة الواحدة
class TipModel {
  final int id;
  final String title;
  final String description;
  final String category;
  final double savingAmount;

  TipModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.savingAmount,
  });

  factory TipModel.fromJson(Map<String, dynamic> json) {
    return TipModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],

      // إذا لم تجد حقل 'category'، استخدم كلمة 'عام' كقيمة افتراضية
      category: json['category'] ?? 'عام',

      savingAmount: (json['saving_amount'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
