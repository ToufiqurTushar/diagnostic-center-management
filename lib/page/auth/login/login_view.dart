import 'package:example/config/app_widgets.dart';
import 'package:example/page/auth/login/login_i18n.dart';
import 'package:example/page/auth/login/login_logic.dart';
import 'package:example/page/auth/otp/otp_view.dart';
import 'package:example/page/auth/signup/signup_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rapid/flutter_rapid.dart';
import '../../../../config/app_theme.dart';

class LoginView extends RapidView<LoginLogic> {
  static const routeName = '/login';

  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              // Logo
              Container(
                width: 56, height: 56,
                decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(14)),
                child: const Icon(Icons.biotech_rounded, color: AppColors.primary, size: 30),
              ),
              const SizedBox(height: 24),
              const Text('Welcome Back 👋', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: AppColors.textDark)),
              const SizedBox(height: 8),
              const Text('Login to book tests and view reports', style: TextStyle(color: AppColors.textGrey, fontSize: 15)),
              const SizedBox(height: 40),

              // Phone tab login
              const Text('Phone Number', style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.textDark, fontSize: 14)),
              const SizedBox(height: 8),
              TextField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: '+880 1X XX XXX XXX',
                  prefixIcon: const Icon(Icons.phone_outlined, color: AppColors.primary),
                  filled: true,
                  fillColor: AppColors.background,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 16),
              FullButton('Send OTP', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const OtpView()))),
              const SizedBox(height: 16),

              // Divider
              Row(children: [
                const Expanded(child: Divider()),
                const Padding(padding: EdgeInsets.symmetric(horizontal: 12), child: Text('OR', style: TextStyle(color: AppColors.textGrey))),
                const Expanded(child: Divider()),
              ]),
              const SizedBox(height: 16),

              // Google login
              FullButton('Continue with Google', outlined: true, onTap: () => _goHome(context)),

              const SizedBox(height: 16),
              FullButton('Continue with Email', outlined: true, color: AppColors.textGrey, onTap: () => _goHome(context)),

              const Spacer(),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text("Don't have an account? ", style: TextStyle(color: AppColors.textGrey)),
                GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SignupView())),
                  child: const Text('Sign Up', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700)),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  void _goHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/main', (_) => false);
  }
  

  @override
  void loadDependentLogics() {
    Get.lazyPut<LoginLogic>(() => LoginLogic());
  }

  @override
  String getRouteName() {
    return routeName;
  }

  @override
  Map<String, Map<String, String>> getI18n() {
    return LoginI18n.getTranslations();
  }
}
