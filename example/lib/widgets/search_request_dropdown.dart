import 'dart:developer';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:animated_custom_dropdown/models/custom_drop_down_item.dart';
import 'package:animated_custom_dropdown_example/models/job.dart';
import 'package:flutter/cupertino.dart';

Future<List<CustomDropDownItem>> _getFakeRequestData(String query) async {
  return await Future.delayed(const Duration(seconds: 1), () {
    return jobItems.where((e) {
      return e.label.toLowerCase().contains(query.toLowerCase());
    }).map((e) => CustomDropDownItem(value: e.value, label: e.label)).toList();
  });
}

class SearchRequestDropdown extends StatelessWidget {
  const SearchRequestDropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomDropdown.searchRequest(
      futureRequest: _getFakeRequestData,
      hintText: 'Search job role',
      onChanged: (value) {
        log('SearchRequestDropdown onChanged value: ${value?.label}');
      },
      searchRequestLoadingIndicator: const Center(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: CupertinoActivityIndicator(),
        ),
      ),
    );
  }
}

class MultiSelectSearchRequestDropdown extends StatelessWidget {
  const MultiSelectSearchRequestDropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomDropdown.multiSelectSearchRequest(
      futureRequest: _getFakeRequestData,
      hintText: 'Search job role',
      onListChanged: (value) {
        log('MultiSelectSearchDropdown onChanged value: ${value.map((e) => e.label)}');
      },
    );
  }
}
