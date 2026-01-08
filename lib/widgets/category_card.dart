import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/category_controller.dart';

class CategoryCard extends StatelessWidget {
  final int index;

  const CategoryCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CategoryController>();
    final category = controller.categories[index];

    return Obx(() {
      final isSelected = controller.isSelected(index);
      return GestureDetector(
        onTap: () => controller.toggleSelection(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          decoration: BoxDecoration(
            color: isSelected ? CategoryController.primaryColor : Colors.white,
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(color: CategoryController.primaryColor, width: 1.5.w),
            boxShadow: isSelected
                ? [
              BoxShadow(
                color: CategoryController.primaryColor.withOpacity(0.3),
                blurRadius: 8.r,
                offset: Offset(0, 4.h),
              ),
            ]
                : [],
          ),
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      category["icon"] as IconData?,
                      size: 36.sp,
                      color: isSelected ? Colors.white : CategoryController.primaryColor,
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      category["name"].toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isSelected ? Colors.white : CategoryController.primaryColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              if (isSelected)
                Positioned(
                  top: 10.h,
                  right: 10.w,
                  child: Icon(Icons.check_circle, color: Colors.white, size: 20.sp),
                ),
            ],
          ),
        ),
      );
    });
  }
}
