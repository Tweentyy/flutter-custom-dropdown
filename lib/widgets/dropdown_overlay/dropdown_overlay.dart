part of '../../custom_dropdown.dart';

const _defaultHeaderPadding = EdgeInsets.all(16.0);
const _overlayOuterPadding =
    EdgeInsetsDirectional.only(bottom: 12, start: 12, end: 12);
const _defaultListItemPadding =
    EdgeInsets.symmetric(vertical: 12, horizontal: 16);

class _DropdownOverlay<T extends CustomDropDownItem> extends StatefulWidget {
  final List<T> items;
  final ScrollController? itemsScrollCtrl;
  final SingleSelectController<T?> selectedItemNotifier;
  final MultiSelectController<T> selectedItemsNotifier;
  final Function(T) onItemSelect;
  final Size size;
  final LayerLink layerLink;
  final VoidCallback hideOverlay;
  final String hintText, searchHintText, noResultFoundText;
  final bool excludeSelected, hideSelectedFieldWhenOpen, canCloseOutsideBounds;
  final _SearchType? searchType;
  final Future<List<T>> Function(String)? futureRequest;
  final Duration? futureRequestDelay;
  final int maxLines;
  final double? overlayHeight;
  final TextStyle? hintStyle, headerStyle, noResultFoundStyle, listItemStyle;
  final EdgeInsets? headerPadding, listItemPadding, itemsListPadding;
  final Widget? searchRequestLoadingIndicator;
  final _ListItemBuilder<T>? listItemBuilder;
  final _HeaderBuilder<T>? headerBuilder;
  final _HeaderListBuilder<T>? headerListBuilder;
  final _HintBuilder? hintBuilder;
  final _NoResultFoundBuilder? noResultFoundBuilder;
  final CustomDropdownDecoration? decoration;
  final _DropdownType dropdownType;

  const _DropdownOverlay({
    Key? key,
    required this.items,
    required this.itemsScrollCtrl,
    required this.size,
    required this.layerLink,
    required this.hideOverlay,
    required this.hintText,
    required this.searchHintText,
    required this.selectedItemNotifier,
    required this.selectedItemsNotifier,
    required this.excludeSelected,
    required this.onItemSelect,
    required this.noResultFoundText,
    required this.canCloseOutsideBounds,
    required this.maxLines,
    required this.overlayHeight,
    required this.dropdownType,
    required this.decoration,
    required this.hintStyle,
    required this.headerStyle,
    required this.listItemStyle,
    required this.noResultFoundStyle,
    required this.hideSelectedFieldWhenOpen,
    required this.searchRequestLoadingIndicator,
    required this.headerPadding,
    required this.itemsListPadding,
    required this.listItemPadding,
    required this.headerBuilder,
    required this.hintBuilder,
    required this.searchType,
    required this.futureRequest,
    required this.futureRequestDelay,
    required this.listItemBuilder,
    required this.headerListBuilder,
    required this.noResultFoundBuilder,
  });

  @override
  _DropdownOverlayState<T> createState() => _DropdownOverlayState<T>();
}

class _DropdownOverlayState<T extends CustomDropDownItem> extends State<_DropdownOverlay<T>> {
  bool displayOverly = true, displayOverlayBottom = true;
  bool isSearchRequestLoading = false;
  bool? mayFoundSearchRequestResult;
  late List<T> items;
  late T? selectedItem;
  late List<T> selectedItems;
  late ScrollController scrollController;
  final key1 = GlobalKey(), key2 = GlobalKey();

  Widget noResultFoundBuilder(BuildContext context) {
    return widget.noResultFoundBuilder != null
        ? widget.noResultFoundBuilder!(context, widget.noResultFoundText)
        : defaultNoResultFoundBuilder(context, widget.noResultFoundText);
  }

  Widget defaultListItemBuilder(
      BuildContext context,
      T result,
      bool isSelected,
      VoidCallback onItemSelect,
      ) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              if (result.icon != null) ...[
                result.icon!,
                const SizedBox(width: 8),
              ],
              Expanded(
                child: Text(
                  result.label,
                  maxLines: widget.maxLines,
                  overflow: TextOverflow.ellipsis,
                  style: widget.listItemStyle ?? const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
        if (widget.dropdownType == _DropdownType.multipleSelect)
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 12.0),
            child: Checkbox(
              onChanged: (_) => onItemSelect(),
              value: isSelected,
              activeColor:
              widget.decoration?.listItemDecoration?.selectedIconColor,
              side: widget.decoration?.listItemDecoration?.selectedIconBorder,
              shape: widget.decoration?.listItemDecoration?.selectedIconShape,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: const VisualDensity(
                horizontal: VisualDensity.minimumDensity,
                vertical: VisualDensity.minimumDensity,
              ),
            ),
          ),
      ],
    );
  }

  Widget defaultNoResultFoundBuilder(BuildContext context, String text) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Text(
          text,
          style: widget.noResultFoundStyle ?? const TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    scrollController = widget.itemsScrollCtrl ?? ScrollController();

    selectedItem = widget.selectedItemNotifier.value;
    selectedItems = widget.selectedItemsNotifier.value;

    widget.selectedItemNotifier.addListener(singleSelectListener);
    widget.selectedItemsNotifier.addListener(multiSelectListener);

    if (widget.excludeSelected &&
        widget.items.length > 1 &&
        selectedItem != null) {
      T value = selectedItem as T;
      items = widget.items.where((item) => item != value).toList();
    } else {
      items = widget.items;
    }
  }

  @override
  void dispose() {
    widget.selectedItemNotifier.removeListener(singleSelectListener);
    widget.selectedItemsNotifier.removeListener(multiSelectListener);

    if (widget.itemsScrollCtrl == null) {
      scrollController.dispose();
    }
    super.dispose();
  }

  void singleSelectListener() {
    if (mounted) {
      selectedItem = widget.selectedItemNotifier.value;
    }
  }

  void multiSelectListener() {
    if (mounted) {
      selectedItems = widget.selectedItemsNotifier.value;
    }
  }

  void onItemSelect(T value) {
    widget.onItemSelect(value);
    if (widget.dropdownType == _DropdownType.singleSelect) {
      setState(() => displayOverly = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // decoration
    final decoration = widget.decoration;

    // search availability check
    final onSearch = widget.searchType != null;

    // overlay offset
    final overlayOffset = Offset(-12, 56);

    // list padding
    final listPadding = onSearch ? const EdgeInsets.only(top: 8) : EdgeInsets.zero;

    // items list
    final list = items.isNotEmpty
        ? _ItemsList<T>(
      scrollController: scrollController,
      listItemBuilder: widget.listItemBuilder ?? defaultListItemBuilder,
      excludeSelected: items.length > 1 ? widget.excludeSelected : false,
      selectedItem: selectedItem,
      selectedItems: selectedItems,
      items: items,
      itemsListPadding: widget.itemsListPadding ?? listPadding,
      listItemPadding: widget.listItemPadding ?? _defaultListItemPadding,
      onItemSelect: onItemSelect,
      decoration: decoration?.listItemDecoration,
      dropdownType: widget.dropdownType,
    )
        : (mayFoundSearchRequestResult != null && !mayFoundSearchRequestResult!) || widget.searchType == _SearchType.onListData
        ? noResultFoundBuilder(context)
        : const SizedBox(height: 12);

    final child = Stack(
      children: [
        Positioned(
          width: widget.size.width + 23.75,
          child: CompositedTransformFollower(
            link: widget.layerLink,
            followerAnchor: Alignment.topLeft,
            showWhenUnlinked: false,
            offset: overlayOffset,
            child: Container(
              key: key1,
              margin: _overlayOuterPadding,
              decoration: BoxDecoration(
                color: decoration?.expandedFillColor ?? CustomDropdownDecoration._defaultFillColor,
                border: decoration?.expandedBorder,
                borderRadius: decoration?.expandedBorderRadius,
                boxShadow: decoration?.expandedShadow
              ),
              child: Material(
                color: Colors.transparent,
                child: _AnimatedSection(
                  animationDismissed: widget.hideOverlay,
                  expand: displayOverly,
                  axisAlignment: 1.0,
                  child: SizedBox(
                    key: key2,
                    height: items.length > 4
                        ? widget.overlayHeight ?? (onSearch ? 270 : 225)
                        : null,
                    child: ClipRRect(
                      borderRadius: decoration?.expandedBorderRadius ?? _defaultBorderRadius,
                      child:
                      NotificationListener<OverscrollIndicatorNotification>(
                        onNotification: (notification) {
                          notification.disallowIndicator();
                          return true;
                        },
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            scrollbarTheme: decoration
                                ?.overlayScrollbarDecoration ??
                                ScrollbarThemeData(
                                  thumbVisibility: WidgetStateProperty.all(
                                    true,
                                  ),
                                  thickness: WidgetStateProperty.all(5),
                                  radius: const Radius.circular(4),
                                  thumbColor: WidgetStateProperty.all(
                                    Colors.grey[300],
                                  ),
                                ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (onSearch && widget.searchType == _SearchType.onListData)
                                Padding(
                                  padding: const EdgeInsets.only(top: 16.0),
                                  child: _SearchField<T>.forListData(
                                    items: widget.items,
                                    searchHintText: widget.searchHintText,
                                    onSearchedItems: (val) {
                                      setState(() => items = val);
                                    },
                                    decoration: decoration?.searchFieldDecoration,
                                  ),
                                )
                              else if (onSearch && widget.searchType == _SearchType.onRequestData)
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: _SearchField<T>.forRequestData(
                                    items: widget.items,
                                    searchHintText: widget.searchHintText,
                                    onFutureRequestLoading: (val) {
                                      setState(() {
                                        isSearchRequestLoading = val;
                                      });
                                    },
                                    futureRequest: widget.futureRequest,
                                    futureRequestDelay: widget.futureRequestDelay,
                                    onSearchedItems: (val) {
                                      setState(() => items = val);
                                    },
                                    mayFoundResult: (val) => mayFoundSearchRequestResult = val,
                                    decoration: decoration?.searchFieldDecoration,
                                  ),
                                ),
                              if (isSearchRequestLoading)
                                widget.searchRequestLoadingIndicator ??
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 20.0,
                                      ),
                                      child: Center(
                                        child: SizedBox(
                                          width: 25,
                                          height: 25,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 3,
                                          ),
                                        ),
                                      ),
                                    )
                              else
                                items.length > 4 ? Expanded(child: list) : list
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );

    if (widget.canCloseOutsideBounds) {
      return Stack(
        children: [
          GestureDetector(
            onTap: () => setState(() => displayOverly = false),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.transparent,
            ),
          ),
          child,
        ],
      );
    }

    return child;
  }
}