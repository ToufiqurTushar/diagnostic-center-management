import 'package:example/config/app_widgets.dart';
import 'package:example/toggle/nearby/nearby_i18n.dart';
import 'package:example/toggle/nearby/nearby_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rapid/flutter_rapid.dart';
import '../../../../config/app_theme.dart';
import '../../../../data/app_data.dart';

class NearbyView extends RapidView<NearbyLogic> {
  static const routeName = '/nearby';
  const NearbyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nearby Centers')),
      body: Column(children: [
        // Fake map placeholder
        Container(
          height: 200,
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFE8F0F8),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.divider),
          ),
          child: Stack(children: [
            Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Icon(Icons.map_outlined, size: 48, color: AppColors.textGrey),
              const SizedBox(height: 8),
              const Text('Interactive Map View', style: TextStyle(color: AppColors.textGrey, fontSize: 14)),
              const Text('(Map integration ready)', style: TextStyle(color: AppColors.textGrey, fontSize: 12)),
            ])),
            // Fake pins
            Positioned(top: 60, left: 80, child: _mapPin(Colors.red)),
            Positioned(top: 90, left: 160, child: _mapPin(AppColors.primary)),
            Positioned(top: 40, right: 70, child: _mapPin(AppColors.accent)),
          ]),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text('${AppData.nearbyCenters.length} centers near you', style: const TextStyle(color: AppColors.textGrey, fontSize: 13)),
          ),
        ),

        const SizedBox(height: 8),

        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            itemCount: AppData.nearbyCenters.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, i) => _centerCard(context, AppData.nearbyCenters[i]),
          ),
        ),
      ]),
    );
  }

  Widget _mapPin(Color color) {
    return Container(
      width: 20, height: 20,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2)),
    );
  }

  Widget _centerCard(BuildContext context, DiagnosticCenter center) {
    return AppCard(
      onTap: () => _showCenterSheet(context, center),
      child: Row(children: [
        Container(
          width: 44, height: 44,
          decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(10)),
          child: const Icon(Icons.local_hospital_outlined, color: AppColors.primary, size: 22),
        ),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(center.name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: AppColors.textDark)),
          const SizedBox(height: 3),
          Text(center.address, style: const TextStyle(color: AppColors.textGrey, fontSize: 12), maxLines: 1, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 3),
          Row(children: [
            const Icon(Icons.star, size: 12, color: Colors.amber),
            const SizedBox(width: 3),
            Text('${center.rating}', style: const TextStyle(color: AppColors.textGrey, fontSize: 12)),
            const SizedBox(width: 8),
            const Icon(Icons.access_time, size: 12, color: AppColors.textGrey),
            const SizedBox(width: 3),
            Text(center.timing, style: const TextStyle(color: AppColors.textGrey, fontSize: 12)),
          ]),
        ])),
        Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Text('${center.distance} km', style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.textDark)),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: center.isOpen ? AppColors.success.withOpacity(0.1) : AppColors.danger.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(center.isOpen ? 'Open' : 'Closed', style: TextStyle(color: center.isOpen ? AppColors.success : AppColors.danger, fontSize: 11, fontWeight: FontWeight.w600)),
          ),
        ]),
      ]),
    );
  }

  void _showCenterSheet(BuildContext context, DiagnosticCenter center) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(center.name, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18, color: AppColors.textDark)),
          const SizedBox(height: 4),
          Text(center.address, style: const TextStyle(color: AppColors.textGrey, fontSize: 13)),
          const SizedBox(height: 16),
          Row(children: [
            _detailChip(Icons.star, '${center.rating} Rating', Colors.amber),
            const SizedBox(width: 10),
            _detailChip(Icons.location_on_outlined, '${center.distance} km', AppColors.primary),
          ]),
          const SizedBox(height: 8),
          Row(children: [
            _detailChip(Icons.access_time, center.timing, AppColors.accent),
            const SizedBox(width: 10),
            _detailChip(
              center.isOpen ? Icons.check_circle_outline : Icons.cancel_outlined,
              center.isOpen ? 'Open Now' : 'Closed',
              center.isOpen ? AppColors.success : AppColors.danger,
            ),
          ]),
          const SizedBox(height: 20),
          Row(children: [
            Expanded(child: FullButton('Get Directions', onTap: () => Navigator.pop(context))),
            const SizedBox(width: 12),
            Expanded(child: FullButton('Call Center', outlined: true, onTap: () => Navigator.pop(context))),
          ]),
          const SizedBox(height: 4),
        ]),
      ),
    );
  }

  Widget _detailChip(IconData icon, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 6),
        Text(label, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600)),
      ]),
    );
  }
  
  @override
  Map<String, Map<String, String>> getI18n() {
    // TODO: implement getI18n
    return NearbyI18n.getTranslations();
  }
  
  @override
  String getRouteName() {
    return routeName;
  }
  
  @override
  void loadDependentLogics() {
    Get.lazyPut<NearbyLogic>(() => NearbyLogic());
  }
}
