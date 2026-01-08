import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'botton_nav_bar/home_screen.dart';
import 'botton_nav_bar/my_tasks_screen.dart';
import 'botton_nav_bar/profile_screen.dart';

class MainDashboard extends StatefulWidget {
  final List<String> selectedCategories;
  final String partnerName;

  const MainDashboard({
    super.key,
    required this.selectedCategories,
    required this.partnerName,
  });

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard>
    with SingleTickerProviderStateMixin {
  static const Color primaryBlue = Color(0xFF3683AB);

  int _currentIndex = 0;

  final List<Map<String, String>> assignedTasks = [];

  late AnimationController _bnvController;

  @override
  void initState() {
    super.initState();
    _bnvController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..forward();
  }

  @override
  void dispose() {
    _bnvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      HomeScreen(
        selectedCategories: widget.selectedCategories,
        partnerName: widget.partnerName,
        onTaskAssigned: (task) {
          setState(() {
            assignedTasks.add(task);
            _currentIndex = 1;
          });
        },
      ),
      MyTasksScreen(tasks: assignedTasks),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 350),
        transitionBuilder: (child, anim) {
          return SlideTransition(
            position: Tween(
              begin: const Offset(0.1, 0),
              end: Offset.zero,
            ).animate(anim),
            child: FadeTransition(opacity: anim, child: child),
          );
        },
        child: screens[_currentIndex],
      ),

      // BOTTOM NAV BAR
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(
              parent: _bnvController,
              curve: Curves.easeOutBack,
            ),
          ),
          child: Container(
            height: 70.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28.r),
              boxShadow: [
                BoxShadow(
                  color: primaryBlue.withOpacity(0.25),
                  blurRadius: 25.r,
                  offset: Offset(0, 12.h),
                ),
              ],
            ),
            child: SalomonBottomBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() => _currentIndex = index);
              },

              selectedItemColor: primaryBlue,
              unselectedItemColor: primaryBlue.withOpacity(0.5),

              items: [
                // HOME
                SalomonBottomBarItem(
                  icon: Icon(Icons.home_rounded, size: 24.sp),
                  title: Text("Home", style: TextStyle(fontSize: 12.sp)),
                  selectedColor: primaryBlue,
                ),

                // MY JOBS
                SalomonBottomBarItem(
                  icon: Stack(
                    children: [
                      Icon(Icons.assignment_rounded, size: 24.sp),
                      if (assignedTasks.isNotEmpty)
                        Positioned(
                          right: -2.w,
                          top: -2.h,
                          child: Container(
                            padding: EdgeInsets.all(4.r),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              assignedTasks.length.toString(),
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  title: Text("My Jobs", style: TextStyle(fontSize: 12.sp)),
                  selectedColor: primaryBlue,
                ),

                // PROFILE
                SalomonBottomBarItem(
                  icon: Icon(Icons.person_rounded, size: 24.sp),
                  title: Text("Profile", style: TextStyle(fontSize: 12.sp)),
                  selectedColor: primaryBlue,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
