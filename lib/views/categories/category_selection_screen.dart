import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:dofix_partner_survey/views/dashboard/main_dashboard.dart';

import '../../controllers/category_controller.dart';
import '../../widgets/category_card.dart';

class CategorySelectionScreen extends StatelessWidget {
  const CategorySelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Select Categories",
                style: TextStyle(
                  color: CategoryController.primaryColor,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                "Choose services you provide",
                style: TextStyle(
                  color: CategoryController.primaryColor.withOpacity(0.7),
                  fontSize: 13.sp,
                ),
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: GridView.builder(
                  itemCount: controller.categories.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 14.w,
                    mainAxisSpacing: 14.h,
                    childAspectRatio: 1.2,
                  ),
                  itemBuilder: (context, index) => CategoryCard(index: index),
                ),
              ),
              SizedBox(height: 12.h),
              Obx(() {
                return InkWell(
                  borderRadius: BorderRadius.circular(16.r),
                  onTap: controller.selectedIndexes.isEmpty
                      ? null
                      : () {
                    final selectedCategories = controller.selectedIndexes
                        .map((i) => controller.categories[i]["name"])
                        .toList();

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MainDashboard(
                          selectedCategories: List<String>.from(selectedCategories),
                          partnerName: 'Happy',
                        ),
                      ),
                    );
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 280),
                    height: 54.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: controller.selectedIndexes.isEmpty
                          ? CategoryController.primaryColor.withOpacity(0.45)
                          : CategoryController.primaryColor,
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: controller.selectedIndexes.isEmpty
                          ? []
                          : [
                        BoxShadow(
                          color: CategoryController.primaryColor.withOpacity(0.35),
                          blurRadius: 14.r,
                          offset: Offset(0, 6.h),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Continue",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Icon(Icons.arrow_forward_rounded,
                              color: Colors.white, size: 18.sp),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
