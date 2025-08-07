// lib/widgets/cards/supplier_card.dart
import 'package:flutter/material.dart';
import 'package:taiz_water_tracker/config/colors.dart';
import 'package:taiz_water_tracker/models/water_supplier_model.dart';
import 'package:url_launcher/url_launcher.dart';

class SupplierCard extends StatelessWidget {
  final WaterSupplierModel supplier;
  const SupplierCard({super.key, required this.supplier});

  Future<void> _makePhoneCall(BuildContext context, String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('لا يمكن إجراء الاتصال بالرقم: $phoneNumber')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 3,
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: AppColors.primary,
          child: Icon(Icons.person, color: Colors.white),
        ),
        title: Text(supplier.name,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('يغطي: ${supplier.areas.join("، ")}'),
        trailing: IconButton(
          icon: const Icon(Icons.call, color: AppColors.secondary),
          onPressed: () => _makePhoneCall(context, supplier.phone),
          tooltip: 'اتصل الآن',
        ),
      ),
    );
  }
}
