// lib/models/pump_schedule_model.dart

// يمثل هذا المودل هيكل بيانات جدول الضخ لحي واحد
class PumpScheduleModel {
  final int id;
  final String name; // اسم الحي
  final List<String> pumpDays; // قائمة بأيام الضخ
  final List<String> pumpTimes; // قائمة بأوقات الضخ

  PumpScheduleModel({
    required this.id,
    required this.name,
    required this.pumpDays,
    required this.pumpTimes,
  });

  // دالة ثابتة لتحويل بيانات JSON إلى كائن من هذا المودل
  factory PumpScheduleModel.fromJson(Map<String, dynamic> json) {
    return PumpScheduleModel(
      id: json['id'],
      name: json['name'],
      // تحويل قائمة البيانات من dynamic إلى List<String>
      pumpDays: List<String>.from(json['pump_days']),
      pumpTimes: List<String>.from(json['pump_times']),
    );
  }
}
