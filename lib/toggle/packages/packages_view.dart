import 'package:example/config/app_widgets.dart';
import 'package:example/page/booking/booking_view.dart';
import 'package:example/toggle/packages/packages_i18n.dart';
import 'package:example/toggle/packages/packages_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rapid/flutter_rapid.dart';
import '../../../../config/app_theme.dart';
import '../../../../data/app_data.dart';

class PackagesView extends RapidView<PackagesLogic> {
  static const routeName = '/packages';
  const PackagesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Health Packages')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: AppData.packages.length,
        separatorBuilder: (_, __) => const SizedBox(height: 14),
        itemBuilder: (context, i) => _packageCard(context, AppData.packages[i]),
      ),
    );
  }

  Widget _packageCard(BuildContext context, TestPackage pkg) {
    final savings = pkg.originalPrice - pkg.discountedPrice;
    final discountPercent = ((savings / pkg.originalPrice) * 100).toInt();

    return AppCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(color: AppColors.accent.withOpacity(0.12), borderRadius: BorderRadius.circular(8)),
          child: Text(pkg.badge, style: const TextStyle(color: AppColors.accent, fontSize: 12, fontWeight: FontWeight.w700)),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(color: AppColors.danger.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
          child: Text('$discountPercent% OFF', style: const TextStyle(color: AppColors.danger, fontSize: 12, fontWeight: FontWeight.w700)),
        ),
      ]),
      const SizedBox(height: 12),
      Text(pkg.name, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 17, color: AppColors.textDark)),
      const SizedBox(height: 4),
      Text(pkg.description, style: const TextStyle(color: AppColors.textGrey, fontSize: 13)),
      const SizedBox(height: 12),

      // Tests included
      Wrap(
        spacing: 6, runSpacing: 6,
        children: pkg.testNames.map((t) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(6)),
          child: Text(t, style: const TextStyle(color: AppColors.primary, fontSize: 12, fontWeight: FontWeight.w500)),
        )).toList(),
      ),

      const SizedBox(height: 16),

      Row(children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('৳${pkg.discountedPrice.toInt()}', style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 22, color: AppColors.primary)),
          Text('৳${pkg.originalPrice.toInt()}', style: const TextStyle(color: AppColors.textGrey, fontSize: 13, decoration: TextDecoration.lineThrough)),
        ]),
        const SizedBox(width: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(color: AppColors.success.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
          child: Text('Save ৳${savings.toInt()}', style: const TextStyle(color: AppColors.success, fontWeight: FontWeight.w700, fontSize: 13)),
        ),
        const Spacer(),
        ElevatedButton(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => BookingView(testName: pkg.name, testPrice: pkg.discountedPrice))),
          style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
          child: const Text('Book Now'),
        ),
      ]),
    ]));
  }
  
  @override
  void loadDependentLogics() {
    Get.lazyPut<PackagesLogic>(() => PackagesLogic());
  }

  @override
  String getRouteName() {
    return routeName;
  }

  @override
  Map<String, Map<String, String>> getI18n() {
    return PackagesI18n.getTranslations();
  }
}
