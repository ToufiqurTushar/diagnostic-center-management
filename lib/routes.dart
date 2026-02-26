import 'package:example/page/auth/login/login_view.dart';
import 'package:example/page/auth/otp/otp_view.dart';
import 'package:example/page/auth/signup/signup_view.dart';
import 'package:example/page/home/main_shell_view.dart';
import 'package:example/page/tests/tests_view.dart';
import 'package:example/toggle/health_dashboard/health_dashboard_view.dart';
import 'package:example/toggle/nearby/nearby_view.dart';
import 'package:example/toggle/notifications/notifications_view.dart';
import 'package:example/toggle/packages/packages_view.dart';
import 'package:example/toggle/patients/patients_view.dart';
import 'package:flutter_rapid/flutter_rapid.dart';
import 'page/home/home_view.dart';

class AppRegistry extends RapidModuleRegistry {
  @override
  List<RapidView> getPages() {
    return [
      const HomeView(),
      const LoginView(),
      const OtpView(),
      const MainShellView(),
      const TestsView(),
      const PackagesView(),
      const NearbyView(),
      const NotificationsView(),
      const PatientsView(),
      const HealthDashboardView(),
      const SignupView(),
    ];
  }
}
