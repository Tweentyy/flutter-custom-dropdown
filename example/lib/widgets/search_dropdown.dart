import 'dart:developer';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:animated_custom_dropdown/models/custom_drop_down_item.dart';
import 'package:flutter/material.dart';

List<CustomDropDownItem> _list = [
  CustomDropDownItem(value: 'pakistani', label: 'Pakistani'),
  CustomDropDownItem(value: 'indian', label: 'Indian'),
  CustomDropDownItem(value: 'middle_eastern', label: 'Middle Eastern'),
  CustomDropDownItem(value: 'western', label: 'Western'),
  CustomDropDownItem(value: 'chinese', label: 'Chinese'),
  CustomDropDownItem(value: 'italian', label: 'Italian'),
];

class SearchDropdown extends StatefulWidget {
  const SearchDropdown({super.key});

  @override
  State<SearchDropdown> createState() => _SearchDropdownState();
}

class _SearchDropdownState extends State<SearchDropdown> {
  CustomDropDownItem? selectedItem = _list[2];

  @override
  Widget build(BuildContext context) {
    return CustomDropdown<CustomDropDownItem>.search(
      hintText: 'Select cuisines',
      items: _list,
      initialItem: selectedItem,
      overlayHeight: 342,
      onChanged: (value) {
        log('SearchDropdown onChanged value: ${value?.label}');
        setState(() {
          selectedItem = value;
        });
      },
    );
  }
}

class MultiSelectSearchDropdown extends StatelessWidget {
  const MultiSelectSearchDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomDropdown<CustomDropDownItem>.multiSelectSearch(
      hintText: 'Select cuisines',
      items: _list,
      onListChanged: (value) {
        log('MultiSelectSearchDropdown onChanged value: ${value.map((e) => e.label)}');
      },
    );
  }
}
