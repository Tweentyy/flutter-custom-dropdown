import 'dart:developer';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:animated_custom_dropdown_example/models/job.dart';
import 'package:flutter/material.dart';

class ValidationDropdown extends StatelessWidget {
  ValidationDropdown({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomDropdown(
            hintText: 'Select job role',
            items: jobItems,
            excludeSelected: false,
            onChanged: (value) {
              log('ValidationDropdown onChanged value: ${value?.label}');
            },
            validator: (value) {
              if (value == null) {
                return "Must not be null";
              }
              return null;
            },
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (!_formKey.currentState!.validate()) {
                  return;
                }
              },
              child: const Text(
                'Submit',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MultiSelectValidationDropdown extends StatelessWidget {
  MultiSelectValidationDropdown({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomDropdown.multiSelect(
            hintText: 'Select job role',
            items: jobItems,
            onListChanged: (value) {
              log('MultiSelectValidationDropdown onChanged value: ${value.map((e) => e.label)}');
            },
            listValidator: (value) {
              if (value.isEmpty) {
                return "Must not be null";
              }
              return null;
            },
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (!_formKey.currentState!.validate()) {
                  return;
                }
              },
              child: const Text(
                'Submit',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
