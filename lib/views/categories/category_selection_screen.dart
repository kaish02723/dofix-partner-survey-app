import 'package:dofix_partner_survey/views/dashboard/main_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategorySelectionScreen extends StatefulWidget {
  const CategorySelectionScreen({super.key});

  @override
  State<CategorySelectionScreen> createState() =>
      _CategorySelectionScreenState();
}

class _CategorySelectionScreenState extends State<CategorySelectionScreen>
    with SingleTickerProviderStateMixin {
  static const Color primaryColor = Color(0xFF3683AB);

  late AnimationController _controller;
  late Animation<double> _fade;

  final List<Map<String, dynamic>> categories = [
    {"name": "Painting", "icon": Icons.format_paint},
    {"name": "Cleaning", "icon": Icons.cleaning_services},
    {"name": "Electrician", "icon": Icons.electrical_services},
    {"name": "Plumber", "icon": Icons.plumbing},
    {"name": "Carpenter", "icon": Icons.handyman},
    {"name": "AC Repair", "icon": Icons.ac_unit},
    {"name": "Pest Control", "icon": Icons.bug_report},
    {"name": "Appliance Repair", "icon": Icons.build},
    {"name": "Water Proofing", "icon": Icons.water_drop},
    {"name": "Interior Work", "icon": Icons.chair},
  ];

  final Set<int> selectedIndexes = {};

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
    _fade = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fade,
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Select Categories",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 6.h),

                Text(
                  "Choose services you provide",
                  style: TextStyle(
                    color: primaryColor.withOpacity(0.7),
                    fontSize: 13.sp,
                  ),
                ),

                SizedBox(height: 20.h),

                // GRID
                Expanded(
                  child: GridView.builder(
                    itemCount: categories.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 14.w,
                      mainAxisSpacing: 14.h,
                      childAspectRatio: 1.2,
                    ),
                    itemBuilder: (context, index) {
                      final isSelected = selectedIndexes.contains(index);
                      return _categoryCard(
                        index,
                        categories[index]["name"],
                        categories[index]["icon"],
                        isSelected,
                      );
                    },
                  ),
                ),

                SizedBox(height: 12.h),

                // CONTINUE BUTTON
                InkWell(
                  borderRadius: BorderRadius.circular(16.r),
                  onTap: selectedIndexes.isEmpty
                      ? null
                      : () {
                    final selectedCategories = selectedIndexes
                        .map((i) => categories[i]["name"])
                        .toList();

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MainDashboard(
                          selectedCategories:
                          List<String>.from(selectedCategories),
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
                      color: selectedIndexes.isEmpty
                          ? primaryColor.withOpacity(0.45)
                          : primaryColor,
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: selectedIndexes.isEmpty
                          ? []
                          : [
                        BoxShadow(
                          color: primaryColor.withOpacity(0.35),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _categoryCard(
      int index, String title, IconData icon, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected
              ? selectedIndexes.remove(index)
              : selectedIndexes.add(index);
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(color: primaryColor, width: 1.5.w),
          boxShadow: isSelected
              ? [
            BoxShadow(
              color: primaryColor.withOpacity(0.3),
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
                    icon,
                    size: 36.sp,
                    color: isSelected ? Colors.white : primaryColor,
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isSelected ? Colors.white : primaryColor,
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
                child: Icon(Icons.check_circle,
                    color: Colors.white, size: 20.sp),
              ),
          ],
        ),
      ),
    );
  }
}
