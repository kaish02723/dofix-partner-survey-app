import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  static const Color primaryColor = Color(0xFF3683AB);

  final categories = [
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

  var selectedIndexes = <int>{}.obs;

  void toggleSelection(int index) {
    if (selectedIndexes.contains(index)) {
      selectedIndexes.remove(index);
    } else {
      selectedIndexes.add(index);
    }
  }

  bool isSelected(int index) => selectedIndexes.contains(index);
}
