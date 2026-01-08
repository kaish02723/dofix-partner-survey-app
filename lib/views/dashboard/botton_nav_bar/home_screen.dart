import 'package:dofix_partner_survey/views/auth/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../categories/category_selection_screen.dart';
import '../../home/task_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  final List<String> selectedCategories;
  final String partnerName;
  final Function(Map<String, String>) onTaskAssigned;

  const HomeScreen({
    super.key,
    required this.selectedCategories,
    required this.partnerName,
    required this.onTaskAssigned,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const Color primaryBlue = Color(0xFF3683AB);

  String selectedFilter = "All";

  final Map<String, List<Map<String, String>>> categoryTasks = {
    "Painting": [
      {"title": "House Painting", "location": "Noida Sec 21", "price": "₹1200"},
      {"title": "Wall Painting", "location": "Delhi", "price": "₹800"},
      {"title": "Roof Painting", "location": "Gurgaon", "price": "₹1500"},
    ],
    "Cleaning": [
      {"title": "Carpet Cleaning", "location": "New Delhi", "price": "₹500"},
      {"title": "Home Cleaning", "location": "Indirapuram", "price": "₹600"},
      {"title": "Bathroom Cleaning", "location": "Faridabad", "price": "₹700"},
    ],
    "Electrician": [
      {"title": "Fan Repair", "location": "Vaishali", "price": "₹450"},
      {"title": "AC Repair", "location": "Noida", "price": "₹800"},
    ],
    "Plumber": [
      {"title": "Bathroom Leakage", "location": "Ghaziabad", "price": "₹700"},
      {"title": "Water Leak", "location": "Faridabad", "price": "₹600"},
    ],
    "Carpenter": [
      {"title": "Carpet Cleaning", "location": "New Delhi", "price": "₹500"},
      {"title": "Home Cleaning", "location": "Indirapuram", "price": "₹600"},
    ],
    "AC Repair": [
      {"title": "Fan Repair", "location": "Vaishali", "price": "₹450"},
      {"title": "AC Repair", "location": "Noida", "price": "₹800"},
    ],
    "Pest Control": [
      {"title": "Bathroom Leakage", "location": "Ghaziabad", "price": "₹700"},
      {"title": "Water Leak", "location": "Faridabad", "price": "₹600"},
    ],
    "Appliance Repair": [
      {"title": "Carpet Cleaning", "location": "New Delhi", "price": "₹500"},
      {"title": "Home Cleaning", "location": "Indirapuram", "price": "₹600"},
    ],
    "Water Proofing": [
      {"title": "Fan Repair", "location": "Vaishali", "price": "₹450"},
      {"title": "AC Repair", "location": "Noida", "price": "₹800"},
    ],
    "Interior Work": [
      {"title": "Bathroom Leakage", "location": "Ghaziabad", "price": "₹700"},
      {"title": "Water Leak", "location": "Faridabad", "price": "₹600"},
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _drawer(),
      appBar: _appBar(),
      body: Padding(
        padding: EdgeInsets.all(10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _categoryFilter(),
            SizedBox(height: 16.h),
            Expanded(child: ListView(children: _buildTasks())),
          ],
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: primaryBlue,
      elevation: 0,
      leading: Builder(
        builder: (context) => IconButton(
          icon: CircleAvatar(
            radius: 18.r,
            backgroundColor: Colors.white.withOpacity(0.2),
            child: Icon(Icons.person, color: Colors.white, size: 20.sp),
          ),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      title: Text(
        widget.partnerName,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 16.sp,
        ),
      ),
      actions: [
        Icon(Icons.notifications_none, color: Colors.white, size: 22.sp),
        SizedBox(width: 10.w),
      ],
    );
  }

  Widget _categoryFilter() {
    final allCategories = ["All", ...widget.selectedCategories];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Categories",
              style: TextStyle(
                color: primaryBlue,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CategorySelectionScreen(),
                  ),
                );
              },
              child: Text(
                "Change",
                style: TextStyle(
                  color: primaryBlue,
                  fontWeight: FontWeight.w600,
                  fontSize: 13.sp,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        SizedBox(
          height: 42.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: allCategories.length,
            separatorBuilder: (_, __) => SizedBox(width: 10.w),
            itemBuilder: (_, index) {
              final category = allCategories[index];
              final isActive = selectedFilter == category;

              return GestureDetector(
                onTap: () => setState(() => selectedFilter = category),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: EdgeInsets.symmetric(
                    horizontal: 18.w,
                    vertical: 10.h,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22.r),
                    color: isActive
                        ? primaryBlue
                        : primaryBlue.withOpacity(0.1),
                    border: Border.all(color: primaryBlue),
                  ),
                  child: Text(
                    category,
                    style: TextStyle(
                      color: isActive ? Colors.white : primaryBlue,
                      fontWeight: FontWeight.w600,
                      fontSize: 13.sp,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  List<Widget> _buildTasks() {
    List<Widget> widgets = [];

    final categories = selectedFilter == "All"
        ? widget.selectedCategories
        : [selectedFilter];

    for (var cat in categories) {
      for (var task in categoryTasks[cat] ?? []) {
        widgets.add(_taskCard(task, cat));
      }
    }
    return widgets;
  }

  Widget _taskCard(Map<String, String> task, String category) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: Colors.white,
        border: Border.all(color: primaryBlue.withOpacity(0.4)),
        boxShadow: [
          BoxShadow(
            color: primaryBlue.withOpacity(0.15),
            blurRadius: 10.r,
            offset: Offset(0, 6.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            task["title"]!,
            style: TextStyle(
              color: primaryBlue,
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            category,
            style: TextStyle(
              color: primaryBlue.withOpacity(0.7),
              fontSize: 12.sp,
            ),
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              Icon(Icons.location_on, size: 14.sp, color: primaryBlue),
              SizedBox(width: 4.w),
              Text(
                task["location"]!,
                style: TextStyle(color: primaryBlue, fontSize: 12.sp),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                task["price"]!,
                style: TextStyle(
                  color: primaryBlue,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TaskDetailScreen(
                        task: task,
                        category: category,
                        onAssign: () {
                          widget.onTaskAssigned({
                            ...task,
                            "category": category,
                          });
                        },
                      ),
                    ),
                  );
                },
                child: Text(
                  "View Task",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _drawer() {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: primaryBlue),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 28.r,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person,
                      color: primaryBlue, size: 30.sp),
                ),
                SizedBox(height: 12.h),
                Text(
                  widget.partnerName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Profile"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.category),
            title: const Text("Change Categories"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CategorySelectionScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Logout", style: TextStyle(color: Colors.red)),
            onTap: _showLogoutSheet,
          ),
        ],
      ),
    );
  }

  void _showLogoutSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => const _LogoutSheet(),
    );
  }
}

// LOGOUT SHEET
class _LogoutSheet extends StatefulWidget {
  const _LogoutSheet();

  @override
  State<_LogoutSheet> createState() => _LogoutSheetState();
}

class _LogoutSheetState extends State<_LogoutSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  static const Color primaryBlue = Color(0xFF3683AB);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );
    _scale = CurvedAnimation(parent: _controller, curve: Curves.elasticOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: ScaleTransition(
        scale: _scale,
        child: Container(
          padding: EdgeInsets.all(22.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(26.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(14.r),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: primaryBlue.withOpacity(0.1),
                ),
                child: Icon(Icons.logout_rounded,
                    color: primaryBlue, size: 34.sp),
              ),
              SizedBox(height: 14.h),
              Text(
                "Logout?",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: primaryBlue,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                "Are you sure you want to logout?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: primaryBlue.withOpacity(0.7),
                  fontSize: 13.sp,
                ),
              ),
              SizedBox(height: 22.h),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        side: const BorderSide(color: primaryBlue),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancel",
                          style: TextStyle(color: primaryBlue)),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        "Logout",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
