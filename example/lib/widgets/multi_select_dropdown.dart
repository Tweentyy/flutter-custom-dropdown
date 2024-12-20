import 'dart:developer';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:animated_custom_dropdown_example/models/job.dart';
import 'package:flutter/material.dart';

class MultiSelectDropdown extends StatelessWidget {
  const MultiSelectDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomDropdown.multiSelect(
      items: jobItems,
      initialItems: jobItems.take(2).toList(),
      onListChanged: (value) {
        log('MultiSelectDropdown onChanged value: ${value.map((e) => e.label)}');
      },
    );
  }
}
