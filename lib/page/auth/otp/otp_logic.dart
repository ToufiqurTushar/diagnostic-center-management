import 'package:flutter_rapid/flutter_rapid.dart';

class OtpLogic extends RapidLogic {
  // 4 OTP controllers
  final List<TextEditingController> controllers =
      List.generate(4, (_) => TextEditingController());

  String get otp =>
      controllers.map((c) => c.text).join();

  bool get isOtpComplete => otp.length == 4;

  void verifyOtp() {
    if (!isOtpComplete) {
      Get.snackbar(
        'Invalid OTP',
        'Please enter 4-digit OTP',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // For MVP → direct login
    Get.offAllNamed('/main');
  }

  void resendOtp() {
    for (var c in controllers) {
      c.clear();
    }

    update();

    Get.snackbar(
      'OTP Sent',
      'A new OTP has been sent',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  @override
  void onClose() {
    for (var c in controllers) {
      c.dispose();
    }
    super.onClose();
  }
}