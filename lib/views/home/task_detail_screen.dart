import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TaskDetailScreen extends StatefulWidget {
  final Map<String, String> task;
  final String category;
  final VoidCallback onAssign;

  const TaskDetailScreen({
    super.key,
    required this.task,
    required this.category,
    required this.onAssign,
  });

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  static const Color primaryBlue = Color(0xFF3683AB);

  final TextEditingController _detailsController = TextEditingController();

  @override
  void dispose() {
    _detailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      /// APP BAR
      appBar: AppBar(
        backgroundColor: primaryBlue,
        elevation: 0,
        title: Text(
          "Task Details",
          style: TextStyle(color: Colors.white, fontSize: 18.sp),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// CATEGORY CHIP
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(color: primaryBlue),
              ),
              child: Text(
                widget.category,
                style: TextStyle(
                  color: primaryBlue,
                  fontWeight: FontWeight.bold,
                  fontSize: 13.sp,
                ),
              ),
            ),

            SizedBox(height: 16.h),

            /// CUSTOMER CARD
            _infoCard(
              title: "Customer Information",
              child: Column(
                children: [
                  _infoRow(Icons.person, "Customer Name", "Rahul Sharma"),
                  _infoRow(
                    Icons.phone,
                    "Phone Number",
                    "9876543210",
                    trailing: IconButton(
                      icon: Icon(Icons.call,
                          color: primaryBlue, size: 20.sp),
                      onPressed: () {},
                    ),
                  ),
                  _infoRow(Icons.location_on, "Location",
                      widget.task["location"]!),
                  _infoRow(Icons.home, "Address",
                      "H-23, Sector 21, Near Metro Station"),
                ],
              ),
            ),

            SizedBox(height: 16.h),

            /// TASK INFO
            _infoCard(
              title: "Task Information",
              child: Column(
                children: [
                  _infoRow(
                      Icons.work, "Task Title", widget.task["title"]!),
                  _infoRow(Icons.currency_rupee, "Budget",
                      widget.task["price"]!),
                ],
              ),
            ),

            SizedBox(height: 16.h),

            /// CUSTOMER NOTES
            _infoCard(
              title: "Customer Notes",
              child: TextField(
                controller: _detailsController,
                maxLines: 4,
                style: TextStyle(color: primaryBlue, fontSize: 14.sp),
                decoration: InputDecoration(
                  hintText: "Customer can write task details here...",
                  hintStyle: TextStyle(
                      color: primaryBlue.withOpacity(0.6),
                      fontSize: 13.sp),
                  filled: true,
                  fillColor: primaryBlue.withOpacity(0.06),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14.r),
                    borderSide: BorderSide(color: primaryBlue),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14.r),
                    borderSide:
                    BorderSide(color: primaryBlue, width: 1.5.w),
                  ),
                ),
              ),
            ),

            SizedBox(height: 24.h),

            /// ASSIGN BUTTON
            InkWell(
              borderRadius: BorderRadius.circular(16.r),
              onTap: () {
                widget.onAssign();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Task Assigned Successfully"),
                    backgroundColor: primaryBlue,
                  ),
                );
              },
              child: Container(
                height: 54.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: primaryBlue,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Center(
                  child: Text(
                    "Assign to Me",
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
    );
  }

  // ================= HELPER WIDGETS =================

  Widget _infoCard({required String title, required Widget child}) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: primaryBlue.withOpacity(0.4)),
        boxShadow: [
          BoxShadow(
            color: primaryBlue.withOpacity(0.12),
            blurRadius: 10.r,
            offset: Offset(0, 6.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: primaryBlue,
              fontWeight: FontWeight.bold,
              fontSize: 15.sp,
            ),
          ),
          SizedBox(height: 12.h),
          child,
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value,
      {Widget? trailing}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18.sp, color: primaryBlue),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: primaryBlue.withOpacity(0.6),
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    color: primaryBlue,
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
          if (trailing != null) trailing,
        ],
      ),
    );
  }
}
