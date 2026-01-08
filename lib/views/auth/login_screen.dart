import 'package:dofix_partner_survey/views/auth/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'otp_verify_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  static const Color primaryBlue = Color(0xFF3683AB);

  late AnimationController _controller;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fade = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _slide = Tween<Offset>(
      begin: const Offset(0, 0.25),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 1.sw,
        height: 1.sh,
        color: primaryBlue,
        child: SafeArea(
          child: FadeTransition(
            opacity: _fade,
            child: SlideTransition(
              position: _slide,
              child: Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(24.w),
                  child: Column(
                    children: [
                      // LOGO
                      Image.asset(
                        "assets/logo/ic_logo_white.png",
                        height: 110.h,
                      ),

                      SizedBox(height: 32.h),

                      // LOGIN CARD
                      Container(
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
                                color: primaryBlue,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            SizedBox(height: 8.h),

                            Text(
                              "Login with your registered mobile number",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: primaryBlue.withOpacity(0.7),
                                fontSize: 13.sp,
                              ),
                            ),

                            SizedBox(height: 24.h),

                            // MOBILE NUMBER FIELD
                            TextField(
                              maxLength: 10,
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                              style: TextStyle(
                                color: primaryBlue,
                                fontSize: 14.sp,
                              ),
                              decoration: InputDecoration(
                                counterText: "",
                                hintText: "Mobile number",
                                hintStyle: TextStyle(
                                  color: primaryBlue.withOpacity(0.6),
                                  fontSize: 14.sp,
                                ),
                                prefixIcon: Icon(
                                  Icons.phone,
                                  color: primaryBlue,
                                  size: 20.sp,
                                ),
                                filled: true,
                                fillColor: primaryBlue.withOpacity(0.08),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.r),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),

                            SizedBox(height: 24.h),

                            // SEND OTP BUTTON
                            InkWell(
                              borderRadius: BorderRadius.circular(16.r),
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => OtpVerifyScreen(
                                      phone: _phoneController.text,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                height: 52.h,
                                decoration: BoxDecoration(
                                  color: primaryBlue,
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
                            ),

                            SizedBox(height: 22.h),

                            // REGISTER
                            Container(
                              padding:
                              EdgeInsets.symmetric(vertical: 12.h),
                              decoration: BoxDecoration(
                                color: primaryBlue.withOpacity(0.06),
                                borderRadius: BorderRadius.circular(14.r),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "New partner? ",
                                    style: TextStyle(
                                      color: primaryBlue,
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                          const RegisterScreen(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "Register account",
                                      style: TextStyle(
                                        color: primaryBlue,
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.bold,
                                        decoration:
                                        TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 22.h),

                      // TERMS & PRIVACY
                      RichText(
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
                      ),
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
}
