import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JobStartScreen extends StatefulWidget {
  const JobStartScreen({super.key});

  @override
  State<JobStartScreen> createState() => _JobStartScreenState();
}

class _JobStartScreenState extends State<JobStartScreen> {
  static const Color primaryBlue = Color(0xFF3683AB);

  String? selectedCategory;
  final TextEditingController noteCtrl = TextEditingController();

  final Map<String, List<String>> categoryMap = {
    "AC Repair": [
      "AC not cooling",
      "Gas leakage",
      "Water leakage",
      "PCB issue",
      "Indoor unit noise",
    ],
    "AC Installation": [
      "New AC installation",
      "Old AC re-installation",
    ],
    "AC Service": [
      "General servicing",
      "Filter cleaning",
      "Cooling check",
    ],
  };

  final Set<String> selectedSubCategories = {};

  int acCount = 1;
  String? acType;
  bool extraCopper = false;
  bool wallDrilling = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: primaryBlue,
        elevation: 0,
        title: Text(
          "Job Start",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔒 LOCKED MAIN CATEGORY
            _lockedInfoCard(
              title: "Main Category",
              value: "AC Services",
            ),

            SizedBox(height: 12.h),

            /// SELECT CATEGORY
            Text(
              "Select Job Category",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: primaryBlue,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 8.h),

            Wrap(
              spacing: 10.w,
              runSpacing: 8.h,
              children: categoryMap.keys.map((cat) {
                final isSelected = selectedCategory == cat;
                return ChoiceChip(
                  label: Text(
                    cat,
                    style: TextStyle(fontSize: 12.sp),
                  ),
                  selected: isSelected,
                  selectedColor: primaryBlue,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : primaryBlue,
                    fontWeight: FontWeight.w600,
                  ),
                  onSelected: (_) {
                    setState(() {
                      selectedCategory = cat;
                      selectedSubCategories.clear();
                      acType = null;
                      acCount = 1;
                      extraCopper = false;
                      wallDrilling = false;
                    });
                  },
                );
              }).toList(),
            ),

            /// SUB CATEGORIES
            if (selectedCategory != null) ...[
              SizedBox(height: 20.h),
              Text(
                "Select Work to be Done",
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: primaryBlue,
                ),
              ),
              SizedBox(height: 10.h),
              ...categoryMap[selectedCategory]!
                  .map((sub) => _subCategoryTile(sub)),
            ],

            /// EXTRA FIELDS FOR INSTALLATION
            if (selectedCategory == "AC Installation") ...[
              SizedBox(height: 20.h),

              Text(
                "Number of ACs",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: primaryBlue,
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(height: 8.h),

              Wrap(
                spacing: 10.w,
                children: [1, 2, 3, 4].map((count) {
                  final selected = acCount == count;
                  return ChoiceChip(
                    label: Text("$count AC",
                        style: TextStyle(fontSize: 12.sp)),
                    selected: selected,
                    selectedColor: primaryBlue,
                    labelStyle: TextStyle(
                      color: selected ? Colors.white : primaryBlue,
                    ),
                    onSelected: (_) {
                      setState(() => acCount = count);
                    },
                  );
                }).toList(),
              ),

              SizedBox(height: 16.h),

              Text(
                "AC Type",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: primaryBlue,
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(height: 8.h),

              Wrap(
                spacing: 10.w,
                children: ["Split AC", "Window AC"].map((type) {
                  final selected = acType == type;
                  return ChoiceChip(
                    label:
                    Text(type, style: TextStyle(fontSize: 12.sp)),
                    selected: selected,
                    selectedColor: primaryBlue,
                    labelStyle: TextStyle(
                      color: selected ? Colors.white : primaryBlue,
                    ),
                    onSelected: (_) {
                      setState(() => acType = type);
                    },
                  );
                }).toList(),
              ),

              SizedBox(height: 16.h),

              Text(
                "Additional Work",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: primaryBlue,
                  fontSize: 14.sp,
                ),
              ),

              CheckboxListTile(
                activeColor: primaryBlue,
                title: Text(
                  "Extra Copper Pipe",
                  style: TextStyle(fontSize: 13.sp),
                ),
                value: extraCopper,
                onChanged: (v) => setState(() => extraCopper = v!),
              ),
              CheckboxListTile(
                activeColor: primaryBlue,
                title: Text(
                  "Wall Drilling",
                  style: TextStyle(fontSize: 13.sp),
                ),
                value: wallDrilling,
                onChanged: (v) => setState(() => wallDrilling = v!),
              ),
            ],

            SizedBox(height: 20.h),

            /// CUSTOMER NOTE
            Text(
              "Customer Notes (Optional)",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: primaryBlue,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 8.h),

            TextField(
              controller: noteCtrl,
              maxLines: 3,
              style: TextStyle(fontSize: 13.sp),
              decoration: InputDecoration(
                hintText: "Describe the issue...",
                hintStyle: TextStyle(fontSize: 12.sp),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14.r),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            SizedBox(height: 30.h),

            /// CONFIRM BUTTON
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryBlue,
                minimumSize: Size(double.infinity, 52.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.r),
                ),
              ),
              onPressed: _confirmJob,
              child: Text(
                "Confirm & Start Job",
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// LOCKED INFO CARD
  Widget _lockedInfoCard({required String title, required String value}) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: primaryBlue.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.lock, color: primaryBlue, size: 18.sp),
          SizedBox(width: 8.w),
          Text(
            "$title: ",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: primaryBlue,
              fontSize: 13.sp,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// SUB CATEGORY TILE
  Widget _subCategoryTile(String title) {
    final selected = selectedSubCategories.contains(title);
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: CheckboxListTile(
        activeColor: primaryBlue,
        value: selected,
        title: Text(title, style: TextStyle(fontSize: 13.sp)),
        onChanged: (val) {
          setState(() {
            val!
                ? selectedSubCategories.add(title)
                : selectedSubCategories.remove(title);
          });
        },
      ),
    );
  }

  /// CONFIRM JOB
  void _confirmJob() {
    if (selectedCategory == null || selectedSubCategories.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Select category & work")),
      );
      return;
    }

    if (selectedCategory == "AC Installation" && acType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select AC type")),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: primaryBlue,
        content: Text(
          "Job Started Successfully\n"
              "Category: $selectedCategory\n"
              "Work: ${selectedSubCategories.join(", ")}\n"
              "ACs: $acCount\n"
              "Type: ${acType ?? "-"}",
        ),
      ),
    );
  }
}
