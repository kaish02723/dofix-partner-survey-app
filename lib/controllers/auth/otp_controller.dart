import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpController extends GetxController {
  static const Color primaryColor = Color(0xFF3683AB);

  late AnimationController animationController;
  late Animation<double> fade;
  late Animation<Offset> slide;

  RxList<TextEditingController> otpControllers = List.generate(6, (_) => TextEditingController()).obs;
  RxInt seconds = 30.obs;
  RxBool isButtonEnabled = false.obs; // button state reactive
  Timer? _timer;

  void startTimer() {
    seconds.value = 30;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds.value == 0) {
        timer.cancel();
      } else {
        seconds.value--;
      }
    });
  }

  void initAnimation(TickerProvider vsync) {
    animationController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 900),
    );

    fade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeIn),
    );

    slide = Tween<Offset>(
      begin: const Offset(0, 0.25),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeOutCubic),
    );

    animationController.forward();
    startTimer();

    // listen to OTP changes
    for (var controller in otpControllers) {
      controller.addListener(_checkOtpFilled);
    }
  }

  void _checkOtpFilled() {
    isButtonEnabled.value = otpControllers.every((c) => c.text.isNotEmpty);
  }

  void disposeController() {
    animationController.dispose();
    _timer?.cancel();
    for (var c in otpControllers) {
      c.dispose();
    }
  }

  String getOtp() {
    return otpControllers.map((e) => e.text).join();
  }

  bool validateOtp() {
    String otp = getOtp();
    if (otp.length < 6) {
      Get.snackbar(
        "Error",
        "Please enter complete 6-digit OTP",
        backgroundColor: Colors.red.shade400,
        colorText: Colors.white,
      );
      return false;
    }
    return true;
  }
}
