import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controllers/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final SplashController controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 1.sw,
        height: 1.sh,
        color: SplashController.primaryBlue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo Animation
            AnimatedBuilder(
              animation: controller.logoController,
              builder: (_, __) {
                return FadeTransition(
                  opacity: controller.fade,
                  child: ScaleTransition(
                    scale: controller.scale,
                    child: RotationTransition(
                      turns: controller.rotate,
                      child: Container(
                        padding: EdgeInsets.all(28.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 20.r,
                              offset: Offset(0, 10.h),
                            ),
                          ],
                        ),
                        child: Image.asset(
                          "assets/logo/ic_logo_white.png",
                          height: 140.h,
                          color: SplashController.primaryBlue,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),

            SizedBox(height: 40.h),

            // Dot Animation
            AnimatedBuilder(
              animation: controller.dotController,
              builder: (_, __) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (index) {
                    final delay = index * 0.25;
                    final value = (controller.dotController.value + delay) % 1.0;

                    return Transform.translate(
                      offset: Offset(0, -8.h * value),
                      child: Opacity(
                        opacity: 0.3 + (0.7 * value),
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 6.w),
                          width: (10 + (4 * value)).w,
                          height: (10 + (4 * value)).w,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    );
                  }),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
