import 'package:example/config/app_widgets.dart';
import 'package:flutter/material.dart';
import '../../../config/app_theme.dart';
import '../../../data/app_data.dart';

class OrdersView extends StatefulWidget {
  static const routeName = '/orders';
  const OrdersView({super.key});

  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> with SingleTickerProviderStateMixin {
  late TabController _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 2, vsync: this);
  }

  List<Booking> get _upcoming => AppData.bookings.where((b) => b.status != 'Report Ready').toList();
  List<Booking> get _history => AppData.bookings.where((b) => b.status == 'Report Ready').toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
        bottom: TabBar(
          controller: _tabs,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textGrey,
          indicatorColor: AppColors.primary,
          tabs: const [Tab(text: 'Upcoming'), Tab(text: 'History')],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: [
          _buildList(_upcoming),
          _buildList(_history),
        ],
      ),
    );
  }

  Widget _buildList(List<Booking> bookings) {
    if (bookings.isEmpty) {
      return const EmptyState(emoji: '📅', title: 'No Orders Yet', subtitle: 'Your bookings will appear here');
    }
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: bookings.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, i) => _bookingCard(context, bookings[i]),
    );
  }

  Widget _bookingCard(BuildContext context, Booking booking) {
    return AppCard(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => OrderDetailView(booking: booking))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Expanded(child: Text(booking.testName, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: AppColors.textDark), maxLines: 1, overflow: TextOverflow.ellipsis)),
          StatusChip(booking.status),
        ]),
        const SizedBox(height: 10),
        Row(children: [
          const Icon(Icons.person_outline, size: 14, color: AppColors.textGrey),
          const SizedBox(width: 4),
          Text(booking.patientName, style: const TextStyle(color: AppColors.textGrey, fontSize: 13)),
          const SizedBox(width: 16),
          const Icon(Icons.calendar_today_outlined, size: 14, color: AppColors.textGrey),
          const SizedBox(width: 4),
          Text(booking.date, style: const TextStyle(color: AppColors.textGrey, fontSize: 13)),
        ]),
        const SizedBox(height: 10),
        Row(children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(6)),
            child: Row(children: [
              Icon(booking.collectionType == 'home' ? Icons.home_outlined : Icons.local_hospital_outlined, size: 12, color: AppColors.primary),
              const SizedBox(width: 4),
              Text(booking.collectionType == 'home' ? 'Home Collection' : 'Lab Visit', style: const TextStyle(color: AppColors.primary, fontSize: 11, fontWeight: FontWeight.w600)),
            ]),
          ),
          const Spacer(),
          Text('৳${booking.amount.toInt()}', style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.textDark, fontSize: 15)),
        ]),
      ]),
    );
  }
}

// ── Order Detail with Status Tracking ───────────────────────────────────────
class OrderDetailView extends StatelessWidget {
  final Booking booking;
  const OrderDetailView({super.key, required this.booking});

  static const List<String> _steps = ['Confirmed', 'Sample Collected', 'Processing', 'Report Ready'];

  int get _currentStep => _steps.indexOf(booking.status).clamp(0, 3);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          AppCard(child: Column(children: [
            InfoRow(icon: Icons.science_outlined, label: 'Test', value: booking.testName.length > 22 ? '${booking.testName.substring(0, 22)}...' : booking.testName),
            const Divider(height: 1),
            InfoRow(icon: Icons.person_outline, label: 'Patient', value: booking.patientName),
            const Divider(height: 1),
            InfoRow(icon: Icons.calendar_today_outlined, label: 'Date', value: booking.date),
            const Divider(height: 1),
            InfoRow(icon: Icons.access_time_outlined, label: 'Slot', value: booking.timeSlot),
            const Divider(height: 1),
            InfoRow(icon: Icons.payment_outlined, label: 'Payment', value: booking.paymentStatus),
          ])),

          const SizedBox(height: 24),

          const Text('Tracking', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: AppColors.textDark)),
          const SizedBox(height: 16),

          // Step tracker
          ..._steps.asMap().entries.map((entry) {
            final i = entry.key;
            final step = entry.value;
            final isDone = i <= _currentStep;
            final isCurrent = i == _currentStep;

            return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Column(children: [
                Container(
                  width: 32, height: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isDone ? AppColors.primary : Colors.white,
                    border: Border.all(color: isDone ? AppColors.primary : AppColors.divider, width: 2),
                  ),
                  child: Icon(
                    isDone ? Icons.check : Icons.circle,
                    size: 14,
                    color: isDone ? Colors.white : AppColors.divider,
                  ),
                ),
                if (i < _steps.length - 1)
                  Container(width: 2, height: 40, color: i < _currentStep ? AppColors.primary : AppColors.divider),
              ]),
              const SizedBox(width: 14),
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(step, style: TextStyle(
                    fontWeight: isCurrent ? FontWeight.w800 : FontWeight.w600,
                    color: isDone ? AppColors.textDark : AppColors.textGrey,
                    fontSize: 14,
                  )),
                  if (isCurrent) const Text('Current Status', style: TextStyle(color: AppColors.primary, fontSize: 12, fontWeight: FontWeight.w600)),
                ]),
              ),
            ]);
          }),

          const SizedBox(height: 24),

          if (booking.status != 'Cancelled' && booking.status != 'Report Ready')
            FullButton('Cancel Booking', outlined: true, color: AppColors.danger, onTap: () => Navigator.pop(context)),
        ]),
      ),
    );
  }
}
