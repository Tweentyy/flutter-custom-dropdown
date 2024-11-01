import 'dart:developer';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:animated_custom_dropdown/models/custom_drop_down_item.dart';
import 'package:flutter/material.dart';

List<CustomDropDownItem> _list = [
  CustomDropDownItem(value: 'developer', label: 'Developer', icon: Icon(Icons.developer_mode)),
  CustomDropDownItem(value: 'designer', label: 'Designer'),
  CustomDropDownItem(value: 'consultant', label: 'Consultant'),
  CustomDropDownItem(value: 'student', label: 'Student', icon: Icon(Icons.school)),
];

class SimpleDropdown extends StatelessWidget {
  const SimpleDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomDropdown<CustomDropDownItem>(
      hintText: 'Select job role',
      items: _list,
      initialItem: null,
      excludeSelected: false,
      overlayController: OverlayPortalController(),
      onChanged: (value) {
        log('SimpleDropdown onChanged value: ${value?.label}');
      },
      decoration: CustomDropdownDecoration(
        suffixIconClosed: const Icon(Icons.keyboard_arrow_down),
        suffixIconExpanded: const Icon(Icons.keyboard_arrow_up),
        closedBorder: Border.all(color: Colors.red),
        closedBorderRadius: BorderRadius.circular(8),
        closedClickedBorder: Border(
            top: BorderSide(color: Colors.blue),
            left: BorderSide(color: Colors.blue),
            right: BorderSide(color: Colors.blue)
        ),
        closedClickedBorderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
        expandedBorder: Border(
            bottom: BorderSide(color: Colors.green),
            left: BorderSide(color: Colors.green),
            right: BorderSide(color: Colors.green)
        ),
        expandedBorderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
    );
  }
}
