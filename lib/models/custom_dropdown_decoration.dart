part of '../custom_dropdown.dart';

class CustomDropdownDecoration {
  /// [CustomDropdown] field color (closed state).
  ///
  /// Default to [Colors.white].
  final Color? closedFillColor;

  /// [CustomDropdown] overlay color (opened/expanded state).
  ///
  /// Default to [Colors.white].
  final Color? expandedFillColor;

  /// [CustomDropdown] box shadow (closed state).
  final List<BoxShadow>? closedShadow;

  /// [CustomDropdown] box shadow (opened/expanded state).
  final List<BoxShadow>? expandedShadow;

  /// Suffix icon for closed state of [CustomDropdown].
  final Widget? suffixIconClosed;

  /// Prefix icon for closed state of [CustomDropdown].
  final Widget? prefixIconClosed;

  /// Suffix icon for opened/expanded state of [CustomDropdown].
  final Widget? suffixIconExpanded;

  /// Prefix icon for opened/expanded state of [CustomDropdown].
  final Widget? prefixIconExpanded;

  /// Border for closed state of [CustomDropdown].
  final BoxBorder? closedBorder;

  /// Border radius for closed state of [CustomDropdown].
  final BorderRadius? closedBorderRadius;

  /// Error border for closed state of [CustomDropdown].
  final BoxBorder? closedErrorBorder;

  /// Error border radius for closed state of [CustomDropdown].
  final BorderRadius? closedErrorBorderRadius;

  /// Clicked border for closed state of [CustomDropdown].
  final BoxBorder? closedClickedBorder;

  /// Clicked border radius for closed state of [CustomDropdown].
  final BorderRadius? closedClickedBorderRadius;

  /// Border for opened/expanded state of [CustomDropdown].
  final BoxBorder? expandedBorder;

  /// Border radius for opened/expanded state of [CustomDropdown].
  final BorderRadius? expandedBorderRadius;

  /// The style to use for the [CustomDropdown] header hint.
  final TextStyle? hintStyle;

  /// The style to use for the [CustomDropdown] header text.
  final TextStyle? headerStyle;

  /// The style to use for the [CustomDropdown] no result found area.
  final TextStyle? noResultFoundStyle;

  /// The style to use for the string returning from [validator].
  final TextStyle? errorStyle;

  /// The style to use for the [CustomDropdown] list item text.
  final TextStyle? listItemStyle;

  /// [CustomDropdown] scrollbar decoration (opened/expanded state).
  final ScrollbarThemeData? overlayScrollbarDecoration;

  /// [CustomDropdown] search field decoration.
  final SearchFieldDecoration? searchFieldDecoration;

  /// [CustomDropdown] list item decoration.
  final ListItemDecoration? listItemDecoration;

  const CustomDropdownDecoration({
    this.closedFillColor,
    this.expandedFillColor,
    this.closedShadow,
    this.expandedShadow,
    this.suffixIconClosed,
    this.prefixIconClosed,
    this.suffixIconExpanded,
    this.prefixIconExpanded,
    this.closedBorder,
    this.closedBorderRadius,
    this.closedErrorBorder,
    this.closedErrorBorderRadius,
    this.closedClickedBorder,
    this.closedClickedBorderRadius,
    this.expandedBorder,
    this.expandedBorderRadius,
    this.hintStyle,
    this.headerStyle,
    this.noResultFoundStyle,
    this.errorStyle,
    this.listItemStyle,
    this.overlayScrollbarDecoration,
    this.searchFieldDecoration,
    this.listItemDecoration,
  });

  static const Color _defaultFillColor = Colors.white;
}
