import 'package:example/config/app_widgets.dart';
import 'package:example/page/auth/otp/otp_view.dart';
import 'package:example/page/auth/signup/signup_i18n.dart';
import 'package:example/page/auth/signup/signup_logic.dart';
import 'package:flutter_rapid/flutter_rapid.dart';
import '../../../../config/app_theme.dart';

class SignupView extends RapidView<SignupLogic> {
  static const routeName = '/signup';
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Create Account ✨', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: AppColors.textDark)),
            const SizedBox(height: 8),
            const Text('Sign up to access diagnostic services', style: TextStyle(color: AppColors.textGrey)),
            const SizedBox(height: 32),

            _label('Full Name'),
            const TextField(decoration: InputDecoration(hintText: 'Enter your full name', prefixIcon: Icon(Icons.person_outline))),
            const SizedBox(height: 16),

            _label('Phone Number'),
            const TextField(keyboardType: TextInputType.phone, decoration: InputDecoration(hintText: '+880 1X XX XXX XXX', prefixIcon: Icon(Icons.phone_outlined))),
            const SizedBox(height: 16),

            _label('Email (Optional)'),
            const TextField(keyboardType: TextInputType.emailAddress, decoration: InputDecoration(hintText: 'your@email.com', prefixIcon: Icon(Icons.email_outlined))),
            const SizedBox(height: 32),

            FullButton('Create Account', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const OtpView()))),
            const SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text('Already have an account? ', style: TextStyle(color: AppColors.textGrey)),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Text('Login', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700)),
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.textDark, fontSize: 14)),
    );
  }
  

  @override
  void loadDependentLogics() {
    Get.lazyPut<SignupLogic>(() => SignupLogic());
  }

  @override
  String getRouteName() {
    return routeName;
  }

  @override
  Map<String, Map<String, String>> getI18n() {
    return SignupI18n.getTranslations();
  }
}
