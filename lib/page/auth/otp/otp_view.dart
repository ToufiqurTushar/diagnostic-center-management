import 'package:example/config/app_widgets.dart';
import 'package:example/page/auth/otp/otp_i18n.dart';
import 'package:example/page/auth/otp/otp_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rapid/flutter_rapid.dart';
import 'package:get/get.dart';
import '../../../../config/app_theme.dart';

class OtpView extends RapidView<OtpLogic> {
  static const routeName = '/otp';
  const OtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OtpLogic>(
      init: OtpLogic(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(backgroundColor: Colors.white),
          body: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Verify OTP 🔒',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Enter the 4-digit code sent to +880 1X XX XXX XXX',
                  style: TextStyle(
                      color: AppColors.textGrey, fontSize: 14),
                ),
                const SizedBox(height: 40),

                // OTP Boxes
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    4,
                    (i) => SizedBox(
                      width: 70,
                      height: 70,
                      child: TextField(
                        controller: controller.controllers[i],
                        maxLength: 1,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700),
                        decoration: InputDecoration(
                          counterText: '',
                          filled: true,
                          fillColor: AppColors.background,
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(14),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(14),
                            borderSide: const BorderSide(
                                color: AppColors.primary,
                                width: 2),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // Verify Button
                FullButton(
                  'Verify & Login',
                  onTap: controller.verifyOtp,
                ),

                const SizedBox(height: 20),

                // Resend
                Center(
                  child: GestureDetector(
                    onTap: controller.resendOtp,
                    child: const Text.rich(
                      TextSpan(
                        text: "Didn't receive code? ",
                        style:
                            TextStyle(color: AppColors.textGrey),
                        children: [
                          TextSpan(
                            text: 'Resend OTP',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  
  @override
  void loadDependentLogics() {
    Get.lazyPut<OtpLogic>(() => OtpLogic());
  }

  @override
  String getRouteName() {
    return routeName;
  }

  @override
  Map<String, Map<String, String>> getI18n() {
    return OtpI18n.getTranslations();
  }
}