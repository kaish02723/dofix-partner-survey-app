import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controllers/auth/register_controller.dart';

class RegisterScreen extends GetView<RegisterController> {
  RegisterScreen({super.key});

  final RegisterController controller = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: RegisterController.primaryBlue,
      body: SafeArea(
        child: FadeTransition(
          opacity: controller.fade,
          child: SlideTransition(
            position: controller.slide,
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(24.w),
                child: Column(
                  children: [
                    Text(
                      "Create Partner Account",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      "Fill details to start receiving jobs",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 13.sp,
                      ),
                    ),
                    SizedBox(height: 14.h),

                    // PROFILE IMAGE
                    GestureDetector(
                      onTap: controller.pickProfileImage,
                      child: Obx(() {
                        File? image = controller.profileImage.value;
                        return Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 44.r,
                              backgroundColor: Colors.white,
                              backgroundImage:
                              image != null ? FileImage(image) : null,
                              child: image == null
                                  ? Icon(Icons.person,
                                  size: 44.sp,
                                  color: RegisterController.primaryBlue)
                                  : null,
                            ),
                            Container(
                              padding: EdgeInsets.all(6.w),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: RegisterController.primaryBlue,
                              ),
                              child: Icon(
                                Icons.camera_alt,
                                size: 16.sp,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                    SizedBox(height: 15.h),

                    // FORM
                    Form(
                      key: controller.formKey,
                      child: Container(
                        width: mq.size.width,
                        padding: EdgeInsets.all(24.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(28.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 20.r,
                              offset: Offset(0, 10.h),
                            )
                          ],
                        ),
                        child: Column(
                          children: [
                            _input(
                              ctrl: controller.nameCtrl,
                              label: "Full Name",
                              icon: Icons.person_outline,
                              validator: (v) =>
                              v!.trim().isEmpty ? "Name required" : null,
                            ),
                            _input(
                              ctrl: controller.addressCtrl,
                              label: "Address",
                              icon: Icons.location_on_outlined,
                              lines: 2,
                              validator: (v) =>
                              v!.trim().isEmpty ? "Address required" : null,
                            ),
                            _input(
                              ctrl: controller.phoneCtrl,
                              label: "Mobile Number",
                              icon: Icons.phone_outlined,
                              keyboard: TextInputType.phone,
                              validator: (v) {
                                if (v!.trim().isEmpty) return "Phone required";
                                if (!RegExp(r'^[0-9]{10}$').hasMatch(v.trim()))
                                  return "Enter valid 10-digit number";
                                return null;
                              },
                            ),
                            _input(
                              ctrl: controller.emailCtrl,
                              label: "Email Address",
                              icon: Icons.email_outlined,
                              keyboard: TextInputType.emailAddress,
                              validator: (v) {
                                if (v!.trim().isEmpty) return null; // optional
                                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                    .hasMatch(v.trim())) return "Enter valid email";
                                return null;
                              },
                            ),
                            _input(
                              ctrl: controller.zoneCtrl,
                              label: "Zone",
                              icon: Icons.map_outlined,
                              validator: (v) =>
                              v!.trim().isEmpty ? "Zone required" : null,
                            ),

                            SizedBox(height: 16.h),

                            // REGISTER BUTTON
                            InkWell(
                              borderRadius: BorderRadius.circular(18.r),
                              onTap: () {
                                // VALIDATE FORM
                                controller.register();

                              },
                              child: Container(
                                height: 54.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: RegisterController.primaryBlue,
                                  borderRadius: BorderRadius.circular(18.r),
                                ),
                                child: Center(
                                  child: Text(
                                    "Register & Continue",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 18.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already registered? ",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 13.sp,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 10.h),
                    Text(
                      "Your information helps us assign nearby jobs",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.75),
                        fontSize: 11.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // SINGLE INPUT FIELD
  Widget _input({
    required TextEditingController ctrl,
    required String label,
    required IconData icon,
    int lines = 1,
    TextInputType keyboard = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 18.h),
      child: TextFormField(
        controller: ctrl,
        maxLines: lines,
        keyboardType: keyboard,
        validator: validator,
        style:
        TextStyle(color: RegisterController.primaryBlue, fontSize: 14.sp),
        decoration: InputDecoration(
          labelText: label,
          labelStyle:
          TextStyle(color: RegisterController.primaryBlue, fontSize: 13.sp),
          prefixIcon:
          Icon(icon, color: RegisterController.primaryBlue, size: 20.sp),
          filled: true,
          fillColor: RegisterController.primaryBlue.withOpacity(0.08),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
