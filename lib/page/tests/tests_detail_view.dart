import 'package:example/config/app_widgets.dart';
import 'package:flutter/material.dart';
import '../../../config/app_theme.dart';
import '../../../data/app_data.dart';
import '../booking/booking_view.dart';

class TestDetailView extends StatelessWidget {
  final LabTest test;

  const TestDetailView({super.key, required this.test});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Test Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Header card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFF0057FF), Color(0xFF00C6AE)]),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Icon(Icons.science_rounded, color: Colors.white70, size: 36),
              const SizedBox(height: 12),
              Text(test.name, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800)),
              const SizedBox(height: 8),
              Text(test.description, style: const TextStyle(color: Colors.white70, fontSize: 14)),
              const SizedBox(height: 16),
              Text('৳${test.price.toInt()}', style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w900)),
            ]),
          ),

          const SizedBox(height: 20),

          // Info cards
          AppCard(child: Column(children: [
            InfoRow(icon: Icons.water_drop_outlined, label: 'Sample Type', value: test.sampleType),
            const Divider(height: 1),
            InfoRow(icon: Icons.schedule_outlined, label: 'Report Delivery', value: test.reportDelivery),
            const Divider(height: 1),
            InfoRow(icon: Icons.fastfood_outlined, label: 'Preparation', value: test.preparation),
          ])),

          const SizedBox(height: 20),

          const Text('What is this test?', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: AppColors.textDark)),
          const SizedBox(height: 8),
          Text(test.description, style: const TextStyle(color: AppColors.textGrey, fontSize: 14, height: 1.6)),

          const SizedBox(height: 20),

          const Text('Collection Options', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: AppColors.textDark)),
          const SizedBox(height: 12),

          Row(children: [
            Expanded(child: _collectionOption('🏠', 'Home Collection', 'Technician visits you')),
            const SizedBox(width: 12),
            Expanded(child: _collectionOption('🏥', 'Lab Visit', 'Visit nearest center')),
          ]),

          const SizedBox(height: 30),
        ]),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: FullButton(
          'Book This Test',
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => BookingView(testName: test.name, testPrice: test.price))),
        ),
      ),
    );
  }

  Widget _collectionOption(String emoji, String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(14)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(emoji, style: const TextStyle(fontSize: 24)),
        const SizedBox(height: 8),
        Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: AppColors.textDark)),
        Text(subtitle, style: const TextStyle(color: AppColors.textGrey, fontSize: 11)),
      ]),
    );
  }
}
