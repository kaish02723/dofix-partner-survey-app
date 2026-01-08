import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashController extends GetxController with GetTickerProviderStateMixin {
  late AnimationController logoController;
  late AnimationController dotController;

  late Animation<double> scale;
  late Animation<double> rotate;
  late Animation<double> fade;

  static const Color primaryBlue = Color(0xFF3683AB);

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

    // Dot Animation
    dotController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();

    logoController.forward();

    _navigateToLogin();
  }

  /// Navigate to LoginScreen after 4 seconds
  void _navigateToLogin() async {
    await Future.delayed(const Duration(seconds: 4));
    Get.offNamed('/login'); // Make sure login route is registered
  }

  @override
  void onClose() {
    logoController.dispose();
    dotController.dispose();
    super.onClose();
  }
}
