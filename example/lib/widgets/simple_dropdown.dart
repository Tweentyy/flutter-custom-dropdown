import 'dart:developer';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:animated_custom_dropdown/models/custom_drop_down_item.dart';
import 'package:flutter/material.dart';

List<CustomDropDownItem> _list = [
  CustomDropDownItem(value: 'Developer', label: 'Developer', icon: Icons.developer_mode),
  CustomDropDownItem(value: 'Designer', label: 'Designer', icon: null),
  CustomDropDownItem(value: 'Consultant', label: 'Consultant', icon: null),
  CustomDropDownItem(value: 'Student', label: 'Student', icon: Icons.school),
];

class SimpleDropdown extends StatelessWidget {
  const SimpleDropdown({Key? key}) : super(key: key);

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
