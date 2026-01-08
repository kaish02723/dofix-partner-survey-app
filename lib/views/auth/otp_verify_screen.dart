import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controllers/auth/otp_controller.dart';
import '../categories/category_selection_screen.dart';

class OtpVerifyScreen extends StatefulWidget {
  final String phone;

  const OtpVerifyScreen({super.key, required this.phone});

  @override
  State<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen>
    with SingleTickerProviderStateMixin {
  final OtpController controller = Get.put(OtpController());

  @override
  void initState() {
    super.initState();
    controller.initAnimation(this);
  }

  @override
  void dispose() {
    controller.disposeController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: FadeTransition(
          opacity: controller.fade,
          child: SlideTransition(
            position: controller.slide,
            child: Padding(
              padding: EdgeInsets.all(24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back button
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.arrow_back,
                      color: OtpController.primaryColor,
                      size: 22.sp,
                    ),
                  ),
                  SizedBox(height: 16.h),

                  Text(
                    "OTP Verification",
                    style: TextStyle(
                      color: OtpController.primaryColor,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.h),

                  Text(
                    "Enter the 6-digit code sent to +91 ${widget.phone}",
                    style: TextStyle(
                      color: OtpController.primaryColor.withOpacity(0.7),
                      fontSize: 13.sp,
                    ),
                  ),
                  SizedBox(height: 36.h),

                  // OTP boxes
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(6, (index) {
                      return _otpBox(index, mq.size.width);
                    }),
                  ),
                  SizedBox(height: 28.h),

                  // Timer / Resend
                  Center(
                    child: Obx(() => controller.seconds.value > 0
                        ? Text(
                      "Resend OTP in ${controller.seconds.value} sec",
                      style: TextStyle(
                        color: OtpController.primaryColor.withOpacity(0.6),
                        fontSize: 13.sp,
                      ),
                    )
                        : TextButton(
                      onPressed: controller.startTimer,
                      child: Text(
                        "Resend OTP",
                        style: TextStyle(
                          color: OtpController.primaryColor,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )),
                  ),
                  const Spacer(),

                  // VERIFY BUTTON
                  Obx(() => InkWell(
                    borderRadius: BorderRadius.circular(16.r),
                    onTap: controller.isButtonEnabled.value
                        ? () {
                      if (controller.validateOtp()) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                              const CategorySelectionScreen()),
                        );
                      }
                    }
                        : null,
                    child: Container(
                      height: 52.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: controller.isButtonEnabled.value
                            ? OtpController.primaryColor
                            : OtpController.primaryColor.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Center(
                        child: Text(
                          "Verify & Continue",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _otpBox(int index, double screenWidth) {
    return SizedBox(
      width: (screenWidth - 48.w) / 7,
      child: TextField(
        controller: controller.otpControllers[index],
        maxLength: 1,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: OtpController.primaryColor,
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          counterText: "",
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: OtpController.primaryColor, width: 1.5.w),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: OtpController.primaryColor, width: 2.w),
          ),
        ),
        onChanged: (value) {
          if (value.isNotEmpty && index < 5) {
            FocusScope.of(context).nextFocus();
          } else if (value.isEmpty && index > 0) {
            FocusScope.of(context).previousFocus();
          }
        },
      ),
    );
  }
}
