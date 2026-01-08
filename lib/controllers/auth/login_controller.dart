import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController
    with GetSingleTickerProviderStateMixin {

  static const Color primaryBlue = Color(0xFF3683AB);

  late AnimationController animationController;
  late Animation<double> fade;
  late Animation<Offset> slide;

  final TextEditingController phoneController = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    fade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeIn),
    );

    slide = Tween<Offset>(
      begin: const Offset(0, 0.25),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeOutCubic,
      ),
    );

    animationController.forward();
  }

  /// ================= SEND OTP =================
  void sendOtp() {
    FocusManager.instance.primaryFocus?.unfocus();

    final String phone = phoneController.text.trim();

    // Empty
    if (phone.isEmpty) {
      _showError("Mobile number required");
      return;
    }

    // Non-numeric
    if (!GetUtils.isNumericOnly(phone)) {
      _showError("Only numbers are allowed");
      return;
    }

    // Length check
    if (phone.length != 10) {
      _showError("Enter valid 10 digit mobile number");
      return;
    }

    // Success
    _showSuccess("OTP sent successfully");

    // Small delay for better UX
    Future.delayed(const Duration(milliseconds: 600), () {
      Get.toNamed(
        '/otp',
        arguments: phone,
      );
    });
  }

  void goToRegister() {
    Get.toNamed('/register');
  }

  /// ================= SNACKBAR HELPERS =================
  void _showError(String message) {
    Get.snackbar(
      "Error",
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.shade500,
      colorText: Colors.white,
      margin: const EdgeInsets.all(12),
      borderRadius: 10,
    );
  }

  void _showSuccess(String message) {
    Get.snackbar(
      "Success",
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.shade600,
      colorText: Colors.white,
      margin: const EdgeInsets.all(12),
      borderRadius: 10,
      icon: const Icon(Icons.check_circle, color: Colors.white),
    );
  }

  @override
  void onClose() {
    animationController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}
