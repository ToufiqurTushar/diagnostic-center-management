import 'package:example/config/app_widgets.dart';
import 'package:example/toggle/health_dashboard/health_dashboard_i18n.dart';
import 'package:example/toggle/health_dashboard/health_dashboard_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rapid/flutter_rapid.dart';
import '../../../../config/app_theme.dart';
import '../../../../data/app_data.dart';

class HealthDashboardView extends RapidView<HealthDashboardLogic> {
  static const routeName = '/health-dashboard';
  const HealthDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Health Dashboard')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Health score
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFF0057FF), Color(0xFF00C6AE)]),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(children: [
              const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Health Score', style: TextStyle(color: Colors.white70, fontSize: 14)),
                SizedBox(height: 8),
                Text('82 / 100', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w900)),
                SizedBox(height: 4),
                Text('Good • Based on last 6 reports', style: TextStyle(color: Colors.white70, fontSize: 13)),
              ])),
              SizedBox(
                width: 80, height: 80,
                child: Stack(alignment: Alignment.center, children: [
                  CircularProgressIndicator(value: 0.82, backgroundColor: Colors.white30, valueColor: const AlwaysStoppedAnimation(Colors.white), strokeWidth: 8),
                  const Text('82%', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14)),
                ]),
              ),
            ]),
          ),

          const SizedBox(height: 24),

          // Quick metrics
          const SectionTitle('Latest Readings'),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(child: _metricCard('🩸', 'Blood Sugar', '102', 'mg/dL', true)),
            const SizedBox(width: 12),
            Expanded(child: _metricCard('❤️', 'Cholesterol', '190', 'mg/dL', true)),
          ]),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(child: _metricCard('🫁', 'Hemoglobin', '14.2', 'g/dL', true)),
            const SizedBox(width: 12),
            Expanded(child: _metricCard('⚗️', 'TSH', '3.2', 'mIU/L', true)),
          ]),

          const SizedBox(height: 24),

          // Blood sugar trend
          const Text('Blood Sugar Trend', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: AppColors.textDark)),
          const SizedBox(height: 12),
          AppCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Row(children: [
              Text('Last 6 Months', style: TextStyle(color: AppColors.textGrey, fontSize: 13)),
              Spacer(),
              Text('Normal Range: 70–100 mg/dL', style: TextStyle(color: AppColors.textGrey, fontSize: 11)),
            ]),
            const SizedBox(height: 16),
            SizedBox(
              height: 120,
              child: _SimpleTrendChart(data: AppData.bloodSugarTrend, maxValue: 150, normalMax: 100, color: AppColors.primary),
            ),
          ])),

          const SizedBox(height: 20),

          // Cholesterol trend
          const Text('Cholesterol Trend', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: AppColors.textDark)),
          const SizedBox(height: 12),
          AppCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Row(children: [
              Text('Last 6 Months', style: TextStyle(color: AppColors.textGrey, fontSize: 13)),
              Spacer(),
              Text('Desirable: < 200 mg/dL', style: TextStyle(color: AppColors.textGrey, fontSize: 11)),
            ]),
            const SizedBox(height: 16),
            SizedBox(
              height: 120,
              child: _SimpleTrendChart(data: AppData.cholesterolTrend, maxValue: 250, normalMax: 200, color: AppColors.accent),
            ),
          ])),

          const SizedBox(height: 24),

          // Suggestions
          const Text('Health Insights', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: AppColors.textDark)),
          const SizedBox(height: 12),
          _insightCard('✅', 'Blood sugar trending down — good job!', AppColors.success),
          const SizedBox(height: 8),
          _insightCard('⚠️', 'Cholesterol slightly elevated, consider dietary changes.', AppColors.warning),
          const SizedBox(height: 8),
          _insightCard('📅', 'Next full body checkup recommended in 3 months.', AppColors.primary),
          const SizedBox(height: 20),
        ]),
      ),
    );
  }

  Widget _metricCard(String emoji, String label, String value, String unit, bool isNormal) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.divider)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Text(emoji, style: const TextStyle(fontSize: 18)),
          const Spacer(),
          Container(
            width: 8, height: 8,
            decoration: BoxDecoration(color: isNormal ? AppColors.success : AppColors.danger, shape: BoxShape.circle),
          ),
        ]),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: AppColors.textGrey, fontSize: 12)),
        const SizedBox(height: 4),
        RichText(text: TextSpan(
          children: [
            TextSpan(text: value, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 22, color: AppColors.textDark)),
            TextSpan(text: ' $unit', style: const TextStyle(fontSize: 11, color: AppColors.textGrey)),
          ],
        )),
      ]),
    );
  }

  Widget _insightCard(String emoji, String text, Color color) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: color.withOpacity(0.07), borderRadius: BorderRadius.circular(12), border: Border.all(color: color.withOpacity(0.2))),
      child: Row(children: [
        Text(emoji, style: const TextStyle(fontSize: 20)),
        const SizedBox(width: 12),
        Expanded(child: Text(text, style: TextStyle(color: color, fontSize: 13, fontWeight: FontWeight.w500))),
      ]),
    );
  }
  
  @override
  Map<String, Map<String, String>> getI18n() {
    return HealthDashboardI18n.getTranslations(); 
  }
  
  @override
  String getRouteName() {
    // TODO: implement getRouteName
    return routeName;
  }
  
  @override
  void loadDependentLogics() {
    // TODO: implement loadDependentLogics
     Get.lazyPut<HealthDashboardLogic>(() => HealthDashboardLogic());
  }
}

// ── Simple bar chart ─────────────────────────────────────────────────────────
class _SimpleTrendChart extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  final double maxValue;
  final double normalMax;
  final Color color;

  const _SimpleTrendChart({required this.data, required this.maxValue, required this.normalMax, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: data.map((item) {
        final value = (item['value'] as int).toDouble();
        final heightPercent = value / maxValue;
        final isHigh = value > normalMax;

        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              Text('${item['value']}', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: isHigh ? AppColors.warning : color)),
              const SizedBox(height: 4),
              Container(
                height: 90 * heightPercent,
                decoration: BoxDecoration(
                  color: isHigh ? AppColors.warning.withOpacity(0.8) : color.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 6),
              Text(item['date'] as String, style: const TextStyle(fontSize: 10, color: AppColors.textGrey)),
            ]),
          ),
        );
      }).toList(),
    );
  }
}
