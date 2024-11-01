import 'package:flutter/material.dart';

class CustomDropDownItem {
  final String value;
  final String label;
  final Widget? icon;

  CustomDropDownItem({required this.value, required this.label, this.icon});

  bool filter(String query) {
    return label.toLowerCase().contains(query.toLowerCase());
  }
}