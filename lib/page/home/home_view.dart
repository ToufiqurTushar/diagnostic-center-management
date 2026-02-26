import 'package:example/config/app_widgets.dart';
import 'package:example/page/home/home_i18n.dart';
import 'package:example/page/home/home_logic.dart';
import 'package:example/toggle/health_dashboard/health_dashboard_view.dart';
import 'package:example/toggle/nearby/nearby_view.dart';
import 'package:example/toggle/notifications/notifications_view.dart';
import 'package:example/toggle/packages/packages_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rapid/flutter_rapid.dart';
import '../../../config/app_theme.dart';
import '../../../data/app_data.dart';
import '../booking/booking_view.dart';
import '../tests/tests_detail_view.dart';
import '../tests/tests_view.dart';

class HomeView extends RapidView<HomeLogic> {
  static const routeName = '/home';
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          _buildHeader(context),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(delegate: SliverChildListDelegate([
              _buildSearchBar(context),
              const SizedBox(height: 20),
              _buildBanner(context),
              const SizedBox(height: 24),
              _buildCategories(context),
              const SizedBox(height: 24),
              _buildPopularTests(context),
              const SizedBox(height: 24),
              _buildPackages(context),
              const SizedBox(height: 24),
              _buildQuickActions(context),
              const SizedBox(height: 24),
              _buildNearby(context),
              const SizedBox(height: 20),
            ])),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 0,
      floating: true,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      title: Row(children: [
        Container(
          width: 36, height: 36,
          decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(10)),
          child: const Icon(Icons.biotech_rounded, color: AppColors.primary, size: 20),
        ),
        const SizedBox(width: 10),
        const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('HealthFirst', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.textDark)),
          Text('Diagnostics', style: TextStyle(fontSize: 11, color: AppColors.textGrey, height: 1)),
        ]),
      ]),
      actions: [
        IconButton(
          icon: const Icon(Icons.dashboard_outlined),
          color: AppColors.primary,
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HealthDashboardView())),
        ),
        Stack(children: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: AppColors.textDark),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsView())),
          ),
          Positioned(
            top: 8, right: 8,
            child: Container(width: 8, height: 8, decoration: const BoxDecoration(color: AppColors.danger, shape: BoxShape.circle)),
          ),
        ]),
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TestsView())),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.divider),
        ),
        child: const Row(children: [
          Icon(Icons.search, color: AppColors.textGrey),
          SizedBox(width: 10),
          Text('Search tests, packages...', style: TextStyle(color: AppColors.textGrey, fontSize: 15)),
        ]),
      ),
    );
  }

  Widget _buildBanner(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF0057FF), Color(0xFF00C6AE)], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(children: [
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(6)),
            child: const Text('20% OFF', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700)),
          ),
          const SizedBox(height: 8),
          const Text('Book Home\nSample Collection', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800, height: 1.3)),
          const SizedBox(height: 4),
          const Text('First booking discount!', style: TextStyle(color: Colors.white70, fontSize: 13)),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TestsView())),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: const Text('Book Now', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700, fontSize: 13)),
            ),
          ),
        ])),
        const Text('🏠\n🩸', style: TextStyle(fontSize: 40, height: 1.5)),
      ]),
    );
  }

  Widget _buildCategories(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SectionTitle('Test Categories', actionLabel: 'See All', onAction: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TestsView()))),
      const SizedBox(height: 14),
      SizedBox(
        height: 90,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: AppData.categories.length,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (context, i) {
            final cat = AppData.categories[i];
            return GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => TestsView(categoryFilter: cat.id))),
              child: Container(
                width: 75,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.divider)),
                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(cat.icon, style: const TextStyle(fontSize: 26)),
                  const SizedBox(height: 4),
                  Text(cat.name, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textDark), textAlign: TextAlign.center, maxLines: 2),
                ]),
              ),
            );
          },
        ),
      ),
    ]);
  }

  Widget _buildPopularTests(BuildContext context) {
    final popularTests = AppData.tests.where((t) => t.isPopular).toList();
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SectionTitle('Popular Tests', actionLabel: 'See All', onAction: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TestsView()))),
      const SizedBox(height: 14),
      ...popularTests.map((test) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: AppCard(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => TestDetailView(test: test))),
          child: Row(children: [
            Container(
              width: 44, height: 44,
              decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(10)),
              child: const Icon(Icons.science_outlined, color: AppColors.primary, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(test.name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: AppColors.textDark)),
              const SizedBox(height: 4),
              Text('${test.sampleType} • Report in ${test.reportDelivery}', style: const TextStyle(color: AppColors.textGrey, fontSize: 12)),
            ])),
            Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Text('৳${test.price.toInt()}', style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.primary, fontSize: 16)),
              const SizedBox(height: 4),
              GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => BookingView(testName: test.name, testPrice: test.price))),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(8)),
                  child: const Text('Book', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
                ),
              ),
            ]),
          ]),
        ),
      )),
    ]);
  }

  Widget _buildPackages(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SectionTitle('Health Packages', actionLabel: 'See All', onAction: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PackagesView()))),
      const SizedBox(height: 14),
      SizedBox(
        height: 190,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: AppData.packages.length,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (context, i) {
            final pkg = AppData.packages[i];
            return GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => BookingView(testName: pkg.name, testPrice: pkg.discountedPrice))),
              child: Container(
                width: 200,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.divider)),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(color: AppColors.accent.withOpacity(0.12), borderRadius: BorderRadius.circular(6)),
                    child: Text(pkg.badge, style: const TextStyle(color: AppColors.accent, fontSize: 11, fontWeight: FontWeight.w700)),
                  ),
                  const SizedBox(height: 8),
                  Text(pkg.name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: AppColors.textDark)),
                  const SizedBox(height: 4),
                  Text('${pkg.testNames.length} Tests Included', style: const TextStyle(color: AppColors.textGrey, fontSize: 12)),
                  const Spacer(),
                  Row(children: [
                    Text('৳${pkg.discountedPrice.toInt()}', style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.primary, fontSize: 17)),
                    const SizedBox(width: 8),
                    Text('৳${pkg.originalPrice.toInt()}', style: const TextStyle(color: AppColors.textGrey, fontSize: 12, decoration: TextDecoration.lineThrough)),
                  ]),
                ]),
              ),
            );
          },
        ),
      ),
    ]);
  }

  Widget _buildQuickActions(BuildContext context) {
    return Row(children: [
      _quickAction(context, '🗺️', 'Nearby Centers', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NearbyView()))),
      const SizedBox(width: 12),
      _quickAction(context, '📊', 'Health Dashboard', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HealthDashboardView()))),
      const SizedBox(width: 12),
      _quickAction(context, '💬', 'Chat Support', () {}),
    ]);
  }

  Widget _quickAction(BuildContext context, String emoji, String label, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.divider)),
          child: Column(children: [
            Text(emoji, style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 6),
            Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textDark), textAlign: TextAlign.center),
          ]),
        ),
      ),
    );
  }

  Widget _buildNearby(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SectionTitle('Nearby Centers', actionLabel: 'View Map', onAction: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NearbyView()))),
      const SizedBox(height: 14),
      ...AppData.nearbyCenters.take(2).map((center) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: AppCard(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NearbyView())),
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
            ])),
            Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Text('${center.distance} km', style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.textDark, fontSize: 13)),
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
        ),
      )),
    ]);
  }
  
  @override
  void loadDependentLogics() {
    Get.lazyPut<HomeLogic>(() => HomeLogic());
  }

  @override
  String getRouteName() {
    return routeName;
  }

  @override
  Map<String, Map<String, String>> getI18n() {
    return HomeI18N.getTranslations();
  }
}
