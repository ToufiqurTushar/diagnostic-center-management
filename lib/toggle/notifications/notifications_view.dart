import 'package:example/toggle/notifications/notifications_i18n.dart';
import 'package:example/toggle/notifications/notifications_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rapid/flutter_rapid.dart';
import '../../../../config/app_theme.dart';

class NotificationsView extends RapidView<NotificationsLogic> {
  static const routeName = '/notifications';
  const NotificationsView({super.key});

  static const List<Map<String, String>> _notifications = [
    {'type': 'report', 'title': 'Report Ready! 📄', 'message': 'Your CBC report is ready to view and download.', 'time': '5 min ago'},
    {'type': 'booking', 'title': 'Booking Confirmed ✅', 'message': 'Your ECG test is confirmed for Mar 20, 11:00 AM.', 'time': '2 hours ago'},
    {'type': 'technician', 'title': 'Technician On The Way 🚗', 'message': 'Your technician is 15 minutes away for sample collection.', 'time': '3 hours ago'},
    {'type': 'offer', 'title': 'Special Offer 🎁', 'message': 'Get 20% off on your first booking. Use code FIRST20.', 'time': '1 day ago'},
    {'type': 'reminder', 'title': 'Upcoming Appointment ⏰', 'message': 'Reminder: Thyroid Profile test tomorrow at 7:00 AM.', 'time': '1 day ago'},
    {'type': 'report', 'title': 'Report Ready! 📄', 'message': 'Your Blood Sugar report is now available.', 'time': '3 days ago'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [TextButton(onPressed: () {}, child: const Text('Mark all read', style: TextStyle(color: AppColors.primary)))],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _notifications.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, i) => _notifCard(_notifications[i], i < 3),
      ),
    );
  }

  Widget _notifCard(Map<String, String> notif, bool isNew) {
    final iconData = switch (notif['type']) {
      'report' => (Icons.description_outlined, AppColors.success),
      'booking' => (Icons.check_circle_outline, AppColors.primary),
      'technician' => (Icons.directions_car_outlined, AppColors.accent),
      'offer' => (Icons.discount_outlined, AppColors.warning),
      _ => (Icons.notifications_outlined, AppColors.textGrey),
    };

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isNew ? AppColors.primaryLight.withOpacity(0.5) : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: isNew ? AppColors.primary.withOpacity(0.2) : AppColors.divider),
      ),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          width: 40, height: 40,
          decoration: BoxDecoration(color: iconData.$2.withOpacity(0.12), shape: BoxShape.circle),
          child: Icon(iconData.$1, color: iconData.$2, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Expanded(child: Text(notif['title']!, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: AppColors.textDark))),
            if (isNew) Container(width: 8, height: 8, decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle)),
          ]),
          const SizedBox(height: 4),
          Text(notif['message']!, style: const TextStyle(color: AppColors.textGrey, fontSize: 13, height: 1.4)),
          const SizedBox(height: 6),
          Text(notif['time']!, style: const TextStyle(color: AppColors.textGrey, fontSize: 11)),
        ])),
      ]),
    );
  }
  
  @override
  void loadDependentLogics() {
    Get.lazyPut<NotificationsLogic>(() => NotificationsLogic());
  }

  @override
  String getRouteName() {
    return routeName;
  }

  @override
  Map<String, Map<String, String>> getI18n() {
    return NotificationsI18n.getTranslations();
  }
}
