part of '../custom_dropdown.dart';

class CustomDropdownDisabledDecoration {
  /// [CustomDropdown] field color (disabled state).
  ///
  /// Default to Color(0xFFF3F3F3).
  final Color? fillColor;

  /// [CustomDropdown] box shadow (disabled state).
  final List<BoxShadow>? shadow;

  /// Suffix icon for disabled and closed state of [CustomDropdown].
  final Widget? suffixIconClosed;

  /// Prefix icon for disabled and closed state of [CustomDropdown].
  final Widget? prefixIconClosed;

  /// Suffix icon for disable and opened/expanded state of [CustomDropdown].
  final Widget? suffixIconExpanded;

  /// Prefix icon for disable and opened/expanded state of [CustomDropdown].
  final Widget? prefixIconExpanded;

  /// Border for disabled state of [CustomDropdown].
  final BoxBorder? border;

  /// Border radius for disabled state of [CustomDropdown].
  final BorderRadius? borderRadius;

  /// The style to use for the [CustomDropdown] header hint (disabled state).
  final TextStyle? hintStyle;

  /// The style to use for the [CustomDropdown] header text (disabled state).
  final TextStyle? headerStyle;

  const CustomDropdownDisabledDecoration({
    this.fillColor,
    this.shadow,
    this.suffixIconClosed,
    this.prefixIconClosed,
    this.suffixIconExpanded,
    this.prefixIconExpanded,
    this.border,
    this.borderRadius,
    this.headerStyle,
    this.hintStyle,
  });
}
