part of '../custom_dropdown.dart';

class SingleSelectController<T extends CustomDropDownItem?> extends ValueNotifier<T?> {
  SingleSelectController(super.value);

  void clear() {
    value = null;
  }

  bool get hasValue => value != null;
}

class MultiSelectController<T extends CustomDropDownItem> extends ValueNotifier<List<T>> {
  MultiSelectController(super.value);

  void add(T valueToAdd) {
    value = [...value, valueToAdd];
  }

  void remove(T valueToRemove) {
    value = value.where((value) => value != valueToRemove).toList();
  }

  void clear() {
    value = [];
  }

  bool get hasValues => value.isNotEmpty;
}
