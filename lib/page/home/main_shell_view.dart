import 'package:example/page/home/main_shell_i18n.dart';
import 'package:example/page/home/main_shell_logic.dart';
import 'package:example/success%20screen/orders/orders_view.dart';
import 'package:example/success%20screen/profile/profile_view.dart';
import 'package:example/success%20screen/reports/reports_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rapid/flutter_rapid.dart';
import 'package:get/get.dart';
import '../../../config/app_theme.dart';
import '../home/home_view.dart';
import '../tests/tests_view.dart';

class MainShellView extends RapidView<MainShellLogic> {
  static const routeName = '/main';
  const MainShellView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainShellLogic>(
      init: MainShellLogic(),
      builder: (controller) {
        final pages = [
          const HomeView(),
          const TestsView(),
          const OrdersView(),
          const ReportsView(),
          const ProfileView(),
        ];

        return Scaffold(
          body: pages[controller.currentIndex],
          bottomNavigationBar: NavigationBar(
            selectedIndex: controller.currentIndex,
            onDestinationSelected: controller.changeTab,
            backgroundColor: Colors.white,
            indicatorColor: AppColors.primaryLight,
            labelBehavior:
                NavigationDestinationLabelBehavior.alwaysShow,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.science_outlined),
                selectedIcon: Icon(Icons.science),
                label: 'Tests',
              ),
              NavigationDestination(
                icon: Icon(Icons.calendar_today_outlined),
                selectedIcon: Icon(Icons.calendar_today),
                label: 'Orders',
              ),
              NavigationDestination(
                icon: Icon(Icons.description_outlined),
                selectedIcon: Icon(Icons.description),
                label: 'Reports',
              ),
              NavigationDestination(
                icon: Icon(Icons.person_outline),
                selectedIcon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
  
  @override
  void loadDependentLogics() {
    Get.lazyPut<MainShellLogic>(() => MainShellLogic());
  }

  @override
  String getRouteName() {
    return routeName;
  }

  @override
  Map<String, Map<String, String>> getI18n() {
    return MainShellI18n.getTranslations();
  }
}