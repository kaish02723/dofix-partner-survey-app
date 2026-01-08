import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controllers/auth/login_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 1.sw,
        height: 1.sh,
        color: LoginController.primaryBlue,
        child: SafeArea(
          child: FadeTransition(
            opacity: controller.fade,
            child: SlideTransition(
              position: controller.slide,
              child: Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(24.w),
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/logo/ic_logo_white.png",
                        height: 110.h,
                      ),

                      SizedBox(height: 32.h),

                      _loginCard(),

                      SizedBox(height: 22.h),

                      _termsText(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// LOGIN CARD WIDGET
  Widget _loginCard() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Partner Login",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: LoginController.primaryBlue,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 8.h),

          Text(
            "Login with your registered mobile number",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: LoginController.primaryBlue.withOpacity(0.7),
              fontSize: 13.sp,
            ),
          ),

          SizedBox(height: 24.h),

          _phoneField(),

          SizedBox(height: 24.h),

          _sendOtpButton(),

          SizedBox(height: 22.h),

          _registerSection(),
        ],
      ),
    );
  }

  Widget _phoneField() {
    return TextField(
      controller: controller.phoneController,
      maxLength: 10,
      keyboardType: TextInputType.phone,
      style: TextStyle(
        color: LoginController.primaryBlue,
        fontSize: 14.sp,
      ),
      decoration: InputDecoration(
        counterText: "",
        hintText: "Mobile number",
        hintStyle: TextStyle(
          color: LoginController.primaryBlue.withOpacity(0.6),
          fontSize: 14.sp,
        ),
        prefixIcon: Icon(
          Icons.phone,
          color: LoginController.primaryBlue,
          size: 20.sp,
        ),
        filled: true,
        fillColor: LoginController.primaryBlue.withOpacity(0.08),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _sendOtpButton() {
    return InkWell(
      borderRadius: BorderRadius.circular(16.r),
      onTap: controller.sendOtp,
      child: Container(
        height: 52.h,
        decoration: BoxDecoration(
          color: LoginController.primaryBlue,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Center(
          child: Text(
            "Send OTP",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _registerSection() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        color: LoginController.primaryBlue.withOpacity(0.06),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "New partner? ",
            style: TextStyle(
              color: LoginController.primaryBlue,
              fontSize: 13.sp,
            ),
          ),
          GestureDetector(
            onTap: controller.goToRegister,
            child: Text(
              "Register account",
              style: TextStyle(
                color: LoginController.primaryBlue,
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _termsText() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(
          fontSize: 11.sp,
          color: Colors.white.withOpacity(0.85),
        ),
        children: const [
          TextSpan(text: "By continuing, you agree to our "),
          TextSpan(
            text: "Terms & Conditions",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
          TextSpan(text: " and "),
          TextSpan(
            text: "Privacy Policy",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
    );
  }
}
