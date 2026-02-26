import 'package:example/config/app_widgets.dart';
import 'package:example/page/tests/tests_i18n.dart';
import 'package:example/page/tests/tests_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rapid/flutter_rapid.dart';
import 'package:get/get.dart';
import '../../../config/app_theme.dart';
import '../../../data/app_data.dart';
import 'tests_detail_view.dart';

class TestsView extends RapidView<TestsLogic> {
  static const routeName = '/tests';
  final String? categoryFilter;

  const TestsView({super.key, this.categoryFilter});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TestsLogic>(
      init: TestsLogic()..setInitialCategory(categoryFilter),
      builder: (controller) {
        final tests = controller.filteredTests;

        return Scaffold(
          appBar: AppBar(title: const Text('Find Tests')),
          body: Column(
            children: [
              // Search bar
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  onChanged: controller.setSearch,
                  autofocus: categoryFilter == null,
                  decoration: const InputDecoration(
                    hintText: 'Search CBC, Blood Sugar, Thyroid...',
                    prefixIcon: Icon(Icons.search, color: AppColors.primary),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),

              // Category chips
              SizedBox(
                height: 42,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: AppData.categories.length + 1,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, i) {
                    if (i == 0) {
                      return _chip(
                        'All',
                        controller.selectedCategory == null,
                        () => controller.setCategory(null),
                      );
                    }

                    final cat = AppData.categories[i - 1];

                    return _chip(
                      '${cat.icon} ${cat.name}',
                      controller.selectedCategory == cat.id,
                      () => controller.setCategory(cat.id),
                    );
                  },
                ),
              ),

              const SizedBox(height: 12),

              // Result count
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${tests.length} tests found',
                    style: const TextStyle(
                        color: AppColors.textGrey, fontSize: 13),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // List
              Expanded(
                child: tests.isEmpty
                    ? const EmptyState(
                        emoji: '🔬',
                        title: 'No Tests Found',
                        subtitle:
                            'Try a different search term or category',
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 4),
                        itemCount: tests.length,
                        separatorBuilder: (_, __) =>
                            const SizedBox(height: 10),
                        itemBuilder: (context, i) =>
                            _testTile(context, tests[i]),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _chip(String label, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: selected ? AppColors.primary : AppColors.divider),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : AppColors.textDark,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _testTile(BuildContext context, LabTest test) {
    return AppCard(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => TestDetailView(test: test),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.science_outlined,
                color: AppColors.primary, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    test.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: AppColors.textDark),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.water_drop_outlined,
                          size: 12, color: AppColors.textGrey),
                      const SizedBox(width: 4),
                      Text(test.sampleType,
                          style: const TextStyle(
                              color: AppColors.textGrey,
                              fontSize: 12)),
                      const SizedBox(width: 12),
                      const Icon(Icons.schedule_outlined,
                          size: 12, color: AppColors.textGrey),
                      const SizedBox(width: 4),
                      Text(test.reportDelivery,
                          style: const TextStyle(
                              color: AppColors.textGrey,
                              fontSize: 12)),
                    ],
                  ),
                ]),
          ),
          Text(
            '৳${test.price.toInt()}',
            style: const TextStyle(
                fontWeight: FontWeight.w800,
                color: AppColors.primary,
                fontSize: 16),
          ),
          const SizedBox(width: 4),
          const Icon(Icons.chevron_right,
              color: AppColors.textGrey),
        ],
      ),
    );
  }
  
  @override
  void loadDependentLogics() {
    Get.lazyPut<TestsLogic>(() => TestsLogic());
  }

  @override
  String getRouteName() {
    return routeName;
  }

  @override
  Map<String, Map<String, String>> getI18n() {
    return TestsI18n.getTranslations();
  }
}