import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with TickerProviderStateMixin {
  static const Color primaryBlue = Color(0xFF3683AB);

  late AnimationController _mainController;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  final nameCtrl = TextEditingController();
  final addressCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final zoneCtrl = TextEditingController();

  File? profileImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickProfileImage() async {
    final XFile? image =
    await _picker.pickImage(source: ImageSource.gallery, imageQuality: 70);

    if (image != null) {
      setState(() {
        profileImage = File(image.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _mainController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _mainController, curve: Curves.easeIn),
    );

    _slide = Tween<Offset>(
      begin: const Offset(0, 0.25),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _mainController, curve: Curves.easeOutCubic),
    );

    _mainController.forward();
  }

  @override
  void dispose() {
    _mainController.dispose();
    nameCtrl.dispose();
    addressCtrl.dispose();
    phoneCtrl.dispose();
    emailCtrl.dispose();
    zoneCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context); // MediaQuery usage

    return Scaffold(
      backgroundColor: primaryBlue,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fade,
          child: SlideTransition(
            position: _slide,
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
                      onTap: _pickProfileImage,
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 44.r,
                            backgroundColor: Colors.white,
                            backgroundImage:
                            profileImage != null ? FileImage(profileImage!) : null,
                            child: profileImage == null
                                ? Icon(
                              Icons.person,
                              size: 44.sp,
                              color: primaryBlue,
                            )
                                : null,
                          ),
                          Container(
                            padding: EdgeInsets.all(6.w),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: primaryBlue,
                            ),
                            child: Icon(
                              Icons.camera_alt,
                              size: 16.sp,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 15.h),

                    // FORM CARD
                    Container(
                      width: mq.size.width, // MediaQuery usage
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
                          _animatedField(
                            delay: 0,
                            child: _input(
                              ctrl: nameCtrl,
                              label: "Full Name",
                              icon: Icons.person_outline,
                            ),
                          ),
                          _animatedField(
                            delay: 100,
                            child: _input(
                              ctrl: addressCtrl,
                              label: "Address",
                              icon: Icons.location_on_outlined,
                              lines: 2,
                            ),
                          ),
                          _animatedField(
                            delay: 200,
                            child: _input(
                              ctrl: phoneCtrl,
                              label: "Mobile Number",
                              icon: Icons.phone_outlined,
                              keyboard: TextInputType.phone,
                            ),
                          ),
                          _animatedField(
                            delay: 300,
                            child: _input(
                              ctrl: emailCtrl,
                              label: "Email Address",
                              icon: Icons.email_outlined,
                              keyboard: TextInputType.emailAddress,
                            ),
                          ),
                          _animatedField(
                            delay: 400,
                            child: Stack(
                              alignment: Alignment.centerRight,
                              children: [
                                _input(
                                  ctrl: zoneCtrl,
                                  label: "Zone",
                                  icon: Icons.map_outlined,
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.info_outline,
                                    color: primaryBlue,
                                    size: 22.sp,
                                  ),
                                  onPressed: _showZoneInfo,
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 16.h),

                          InkWell(
                            borderRadius: BorderRadius.circular(18.r),
                            onTap: () {
                              FocusScope.of(context).unfocus();
                            },
                            child: Container(
                              height: 54.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: primaryBlue,
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
                          onTap: () => Navigator.pop(context),
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

  Widget _input({
    required TextEditingController ctrl,
    required String label,
    required IconData icon,
    int lines = 1,
    TextInputType keyboard = TextInputType.text,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 18.h),
      child: TextField(
        controller: ctrl,
        maxLines: lines,
        keyboardType: keyboard,
        style: TextStyle(color: primaryBlue, fontSize: 14.sp),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: primaryBlue, fontSize: 13.sp),
          prefixIcon: Icon(icon, color: primaryBlue, size: 20.sp),
          filled: true,
          fillColor: primaryBlue.withOpacity(0.08),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _animatedField({required Widget child, required int delay}) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOut,
      builder: (_, value, __) => Opacity(
        opacity: value,
        child: Transform.translate(
          offset: Offset(0, 20.h * (1 - value)),
          child: child,
        ),
      ),
    );
  }

  void _showZoneInfo() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22.r)),
      ),
      builder: (_) => Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "What is Zone?",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: primaryBlue,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              "Zone helps us assign nearby service requests faster.\n\nExample:\n• North Zone\n• South Zone\n• Area Name",
              style: TextStyle(fontSize: 14.sp),
            ),
          ],
        ),
      ),
    );
  }
}
