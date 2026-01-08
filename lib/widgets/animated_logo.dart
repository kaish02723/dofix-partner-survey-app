// lib/controllers/splash_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashController extends GetxController
    with GetTickerProviderStateMixin {
  late AnimationController logoController;
  late AnimationController dotController;

  late Animation<double> scale;
  late Animation<double> rotate;
  late Animation<double> fade;

  @override
  void onInit() {
    super.onInit();

    // Logo Animation
    logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    scale = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: logoController, curve: Curves.easeOutBack),
    );

    rotate = Tween<double>(begin: -0.03, end: 0).animate(
      CurvedAnimation(parent: logoController, curve: Curves.easeOut),
    );

    fade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: logoController, curve: Curves.easeIn),
    );

    logoController.forward();

    // Dots Animation
    dotController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();

    // Navigate after delay
    Future.delayed(const Duration(seconds: 4), () {
      // Check if Get is ready
      if (Get.isRegistered<SplashController>()) {
        Get.offNamed('/login');
      }
    });
  }

  @override
  void onClose() {
    logoController.dispose();
    dotController.dispose();
    super.onClose();
  }
}
