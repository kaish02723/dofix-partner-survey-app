import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RegisterController extends GetxController
    with GetSingleTickerProviderStateMixin {

  static const Color primaryBlue = Color(0xFF3683AB);

  // Animations
  late AnimationController animationController;
  late Animation<double> fade;
  late Animation<Offset> slide;

  // Form key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Controllers
  final nameCtrl = TextEditingController();
  final addressCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final zoneCtrl = TextEditingController();

  final Rx<File?> profileImage = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();

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
      CurvedAnimation(parent: animationController, curve: Curves.easeOutCubic),
    );

    animationController.forward();
  }

  Future<void> pickProfileImage() async {
    final XFile? image =
    await _picker.pickImage(source: ImageSource.gallery, imageQuality: 70);
    if (image != null) {
      profileImage.value = File(image.path);
    }
  }

  // Updated register function with form validation
  void register() {
    FocusManager.instance.primaryFocus?.unfocus();

    if (formKey.currentState!.validate()) {
      // All fields valid
      Get.snackbar(
        "Success",
        "Registration completed successfully",
        backgroundColor: Colors.green.shade400,
        colorText: Colors.white,
      );

    } else {
      // Highlights invalid fields automatically
      Get.snackbar(
        "Error",
        "Please fill all required fields correctly",
        backgroundColor: Colors.red.shade400,
        colorText: Colors.white,
      );
    }

  }

  @override
  void onClose() {
    animationController.dispose();
    nameCtrl.dispose();
    addressCtrl.dispose();
    phoneCtrl.dispose();
    emailCtrl.dispose();
    zoneCtrl.dispose();
    super.onClose();
  }
}

