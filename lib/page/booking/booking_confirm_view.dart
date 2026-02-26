import 'package:example/config/app_widgets.dart';
import 'package:flutter/material.dart';
import '../../../config/app_theme.dart';

class BookingConfirmView extends StatefulWidget {
  final String testName;
  final String patientName;
  final String date;
  final String time;
  final String collectionType;
  final double amount;

  const BookingConfirmView({
    super.key,
    required this.testName,
    required this.patientName,
    required this.date,
    required this.time,
    required this.collectionType,
    required this.amount,
  });

  @override
  State<BookingConfirmView> createState() => _BookingConfirmViewState();
}

class _BookingConfirmViewState extends State<BookingConfirmView> {
  String _paymentMethod = 'online';
  bool _confirmed = false;

  @override
  Widget build(BuildContext context) {
    if (_confirmed) return _successScreen(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Confirm & Pay')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Booking summary
          const Text('Booking Summary', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: AppColors.textDark)),
          const SizedBox(height: 12),
          AppCard(child: Column(children: [
            InfoRow(icon: Icons.science_outlined, label: 'Test', value: widget.testName.length > 25 ? '${widget.testName.substring(0, 25)}...' : widget.testName),
            const Divider(height: 1),
            InfoRow(icon: Icons.person_outline, label: 'Patient', value: widget.patientName),
            const Divider(height: 1),
            InfoRow(icon: Icons.calendar_today_outlined, label: 'Date', value: widget.date),
            const Divider(height: 1),
            InfoRow(icon: Icons.access_time_outlined, label: 'Time', value: widget.time),
            const Divider(height: 1),
            InfoRow(icon: Icons.location_on_outlined, label: 'Collection', value: widget.collectionType == 'home' ? 'Home' : 'Lab Visit'),
          ])),

          const SizedBox(height: 20),

          const Text('Payment Method', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: AppColors.textDark)),
          const SizedBox(height: 12),

          _paymentOption('online', '💳', 'Online Payment', 'Card / Mobile Banking'),
          const SizedBox(height: 10),
          _paymentOption('cash', '💵', 'Cash on Collection', 'Pay when sample is collected'),

          const SizedBox(height: 20),

          AppCard(child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text('Total Amount', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: AppColors.textDark)),
            Text('৳${widget.amount.toInt()}', style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 20, color: AppColors.primary)),
          ])),

          const SizedBox(height: 30),
        ]),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: FullButton('Confirm Booking', onTap: () => setState(() => _confirmed = true)),
      ),
    );
  }

  Widget _paymentOption(String type, String emoji, String title, String subtitle) {
    final isSelected = _paymentMethod == type;
    return GestureDetector(
      onTap: () => setState(() => _paymentMethod = type),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryLight : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: isSelected ? AppColors.primary : AppColors.divider, width: isSelected ? 1.5 : 1),
        ),
        child: Row(children: [
          Text(emoji, style: const TextStyle(fontSize: 28)),
          const SizedBox(width: 12),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: isSelected ? AppColors.primary : AppColors.textDark)),
            Text(subtitle, style: const TextStyle(color: AppColors.textGrey, fontSize: 12)),
          ]),
          const Spacer(),
          if (isSelected) const Icon(Icons.check_circle, color: AppColors.primary),
        ]),
      ),
    );
  }

  Widget _successScreen(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              width: 100, height: 100,
              decoration: BoxDecoration(color: AppColors.success.withOpacity(0.1), shape: BoxShape.circle),
              child: const Icon(Icons.check_circle_rounded, size: 60, color: AppColors.success),
            ),
            const SizedBox(height: 24),
            const Text('Booking Confirmed! 🎉', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: AppColors.textDark), textAlign: TextAlign.center),
            const SizedBox(height: 12),
            const Text('Your booking is confirmed. Our team will contact you shortly.', style: TextStyle(color: AppColors.textGrey, fontSize: 15), textAlign: TextAlign.center),
            const SizedBox(height: 32),

            AppCard(child: Column(children: [
              InfoRow(icon: Icons.science_outlined, label: 'Test', value: widget.testName.length > 20 ? '${widget.testName.substring(0, 20)}...' : widget.testName),
              const Divider(height: 1),
              InfoRow(icon: Icons.calendar_today_outlined, label: 'Date', value: widget.date),
              const Divider(height: 1),
              InfoRow(icon: Icons.access_time_outlined, label: 'Time', value: widget.time),
            ])),

            const SizedBox(height: 32),
            FullButton('Go to Home', onTap: () => Navigator.pushNamedAndRemoveUntil(context, '/main', (_) => false)),
            const SizedBox(height: 12),
            FullButton('View My Orders', outlined: true, onTap: () => Navigator.pushNamedAndRemoveUntil(context, '/main', (_) => false)),
          ]),
        ),
      ),
    );
  }
}
