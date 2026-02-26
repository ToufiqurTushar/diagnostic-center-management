import 'package:example/config/app_widgets.dart';
import 'package:flutter/material.dart';
import '../../../config/app_theme.dart';
import '../../../data/app_data.dart';

class ReportsView extends StatelessWidget {
  static const routeName = '/reports';
  const ReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Reports')),
      body: AppData.reports.isEmpty
          ? const EmptyState(emoji: '📄', title: 'No Reports Yet', subtitle: 'Your test reports will appear here')
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: AppData.reports.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, i) => _reportCard(context, AppData.reports[i]),
            ),
    );
  }

  Widget _reportCard(BuildContext context, Report report) {
    final isAvailable = report.status == 'Available';
    return AppCard(
      onTap: isAvailable ? () => Navigator.push(context, MaterialPageRoute(builder: (_) => ReportDetailView(report: report))) : null,
      child: Row(children: [
        Container(
          width: 44, height: 44,
          decoration: BoxDecoration(
            color: isAvailable ? AppColors.success.withOpacity(0.1) : AppColors.warning.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(Icons.description_outlined, color: isAvailable ? AppColors.success : AppColors.warning, size: 22),
        ),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(report.testName, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: AppColors.textDark), maxLines: 1, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 4),
          Text(report.patientName, style: const TextStyle(color: AppColors.textGrey, fontSize: 12)),
          Text(report.date, style: const TextStyle(color: AppColors.textGrey, fontSize: 12)),
        ])),
        Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          StatusChip(report.status),
          if (isAvailable) ...[
            const SizedBox(height: 8),
            const Icon(Icons.download_outlined, color: AppColors.primary, size: 20),
          ],
        ]),
      ]),
    );
  }
}

// ── Report Detail ───────────────────────────────────────────────────────────
class ReportDetailView extends StatelessWidget {
  final Report report;
  const ReportDetailView({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report'),
        actions: [
          IconButton(icon: const Icon(Icons.share_outlined), onPressed: () => _showShareSheet(context)),
          IconButton(icon: const Icon(Icons.download_outlined, color: AppColors.primary), onPressed: () => _showSnack(context, 'Downloading PDF...')),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          AppCard(child: Column(children: [
            InfoRow(icon: Icons.science_outlined, label: 'Test', value: report.testName.length > 22 ? '${report.testName.substring(0, 22)}...' : report.testName),
            const Divider(height: 1),
            InfoRow(icon: Icons.person_outline, label: 'Patient', value: report.patientName),
            const Divider(height: 1),
            InfoRow(icon: Icons.calendar_today_outlined, label: 'Date', value: report.date),
            const Divider(height: 1),
            InfoRow(icon: Icons.check_circle_outline, label: 'Status', value: report.status),
          ])),

          const SizedBox(height: 20),

          // Fake report viewer
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.divider)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('🔬 Test Results', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: AppColors.textDark)),
              const SizedBox(height: 16),
              _resultRow('Hemoglobin (Hb)', '14.2 g/dL', '13.0–17.0', true),
              _resultRow('WBC Count', '7.4 × 10³/μL', '4.5–11.0', true),
              _resultRow('RBC Count', '4.8 × 10⁶/μL', '4.5–5.9', true),
              _resultRow('Platelets', '185 × 10³/μL', '150–400', true),
              _resultRow('Hematocrit', '43%', '41–53%', true),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: AppColors.success.withOpacity(0.08), borderRadius: BorderRadius.circular(10)),
                child: const Row(children: [
                  Icon(Icons.check_circle, color: AppColors.success, size: 20),
                  SizedBox(width: 8),
                  Text('All values within normal range', style: TextStyle(color: AppColors.success, fontWeight: FontWeight.w600)),
                ]),
              ),
            ]),
          ),

          const SizedBox(height: 20),

          Row(children: [
            Expanded(child: FullButton('Download PDF', onTap: () => _showSnack(context, 'Downloading...'))),
            const SizedBox(width: 12),
            Expanded(child: FullButton('Share', outlined: true, onTap: () => _showShareSheet(context))),
          ]),
        ]),
      ),
    );
  }

  Widget _resultRow(String name, String value, String range, bool isNormal) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(children: [
        Expanded(child: Text(name, style: const TextStyle(fontSize: 13, color: AppColors.textDark))),
        Text(value, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: isNormal ? AppColors.textDark : AppColors.danger)),
        const SizedBox(width: 12),
        Text(range, style: const TextStyle(color: AppColors.textGrey, fontSize: 11)),
        const SizedBox(width: 8),
        Icon(isNormal ? Icons.check : Icons.warning_amber_rounded, size: 14, color: isNormal ? AppColors.success : AppColors.danger),
      ]),
    );
  }

  void _showSnack(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg), behavior: SnackBarBehavior.floating));
  }

  void _showShareSheet(BuildContext context) {
    showModalBottomSheet(context: context, shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))), builder: (_) => Padding(
      padding: const EdgeInsets.all(24),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Text('Share Report', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: AppColors.textDark)),
        const SizedBox(height: 20),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          _shareOption(context, '📱', 'WhatsApp'),
          _shareOption(context, '📧', 'Email'),
          _shareOption(context, '🔗', 'Copy Link'),
        ]),
        const SizedBox(height: 10),
      ]),
    ));
  }

  Widget _shareOption(BuildContext context, String emoji, String label) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sharing via $label...'), behavior: SnackBarBehavior.floating));
      },
      child: Column(children: [
        Container(
          width: 56, height: 56,
          decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(14)),
          child: Center(child: Text(emoji, style: const TextStyle(fontSize: 26))),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textDark)),
      ]),
    );
  }
}
