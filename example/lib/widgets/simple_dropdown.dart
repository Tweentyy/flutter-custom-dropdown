import 'dart:developer';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:animated_custom_dropdown/models/custom_drop_down_item.dart';
import 'package:flutter/material.dart';

List<CustomDropDownItem> _list = [
  CustomDropDownItem(value: 'developer', label: 'Developer', icon: Icons.developer_mode),
  CustomDropDownItem(value: 'designer', label: 'Designer'),
  CustomDropDownItem(value: 'consultant', label: 'Consultant'),
  CustomDropDownItem(value: 'student', label: 'Student', icon: Icons.school),
];

class SimpleDropdown extends StatelessWidget {
  const SimpleDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomDropdown(
      hintText: 'Select job role',
      items: _list,
      initialItem: _list[0],
      excludeSelected: false,
      onChanged: (value) {
        log('SimpleDropdown onChanged value: ${value?.label}');
      },
    );
  }
}
