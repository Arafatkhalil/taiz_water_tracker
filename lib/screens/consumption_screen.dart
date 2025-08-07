// lib/screens/consumption_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taiz_water_tracker/models/water_consumption_model.dart';
import 'package:taiz_water_tracker/services/storage_service.dart';
import 'package:taiz_water_tracker/widgets/common/custom_app_bar.dart';

class ConsumptionScreen extends StatefulWidget {
  const ConsumptionScreen({super.key});

  @override
  State<ConsumptionScreen> createState() => _ConsumptionScreenState();
}

class _ConsumptionScreenState extends State<ConsumptionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  String _selectedCategory = 'شرب';
  final List<String> _categories = ['شرب', 'طبخ', 'نظافة', 'غسيل', 'أخرى'];

  Future<void> _saveConsumption() async {
    // التحقق من صحة النموذج
    if (_formKey.currentState!.validate()) {
      final amount = double.tryParse(_amountController.text);
      if (amount == null) return;

      final newConsumption = WaterConsumptionModel(
        amount: amount,
        date: DateTime.now(),
        category: _selectedCategory,
      );

      // حفظ البيانات في قاعدة البيانات
      await StorageService.instance.insertConsumption(newConsumption);

      // إظهار رسالة تأكيد
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم حفظ الاستهلاك بنجاح!')),
      );

      // الرجوع إلى الشاشة السابقة
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'تسجيل استهلاك جديد'),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(24.0),
          children: [
            // حقل إدخال الكمية
            TextFormField(
              controller: _amountController,
              decoration: const InputDecoration(
                labelText: 'الكمية (باللتر)',
                prefixIcon: Icon(Icons.opacity),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'الرجاء إدخال الكمية';
                }
                if (double.tryParse(value) == null) {
                  return 'الرجاء إدخال رقم صحيح';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            // قسم اختيار الفئة
            const Text('اختر الفئة:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              children: _categories.map((category) {
                return ChoiceChip(
                  label: Text(category),
                  selected: _selectedCategory == category,
                  onSelected: (selected) {
                    setState(() {
                      _selectedCategory = category;
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 40),
            // زر الحفظ
            ElevatedButton.icon(
              onPressed: _saveConsumption,
              icon: const Icon(Icons.save),
              label: const Text('حفظ'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
