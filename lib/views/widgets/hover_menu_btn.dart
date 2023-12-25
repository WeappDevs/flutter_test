import 'dart:async';
import 'package:admin_web_app/models/fitter_model.dart';
import 'package:admin_web_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HoverMenuButton extends StatefulWidget {
  final Widget? btnChild;
  final double? width;
  final List<Widget>? items;
  final String? btnText;
  final List<FilterModel> filterList;
  final RxList<FilterModel>? selectedFilterList;
  final bool? isSingleSelection;
  final int? maxShownItemCount;
  final VoidCallback? onChanged;

  const HoverMenuButton({
    super.key,
    this.btnChild,
    this.width,
    this.items,
    required this.btnText,
    required this.filterList,
    required this.selectedFilterList,
    this.isSingleSelection,
    this.maxShownItemCount,
    this.onChanged,
  });

  @override
  State<HoverMenuButton> createState() => _HoverMenuButtonState();
}

class _HoverMenuButtonState extends State<HoverMenuButton> {
  final GlobalKey _overlayKey = GlobalKey();
  OverlayEntry? _overlayEntry;
  bool _isButtonHovered = false;
  bool _isMenuHovered = false;
  Timer? _menuTimer;

  void _showMenu(BuildContext context) {
    if (_overlayEntry == null) {
      final renderBox = context.findRenderObject() as RenderBox;
      final size = renderBox.size;
      final offset = renderBox.localToGlobal(Offset.zero);

      _overlayEntry = OverlayEntry(
        builder: (context) {
          return Positioned(
            key: _overlayKey,
            left: offset.dx,
            top: offset.dy + size.height - 10,
            width: widget.width ?? 200,
            child: MouseRegion(
              onEnter: (value) {
                setState(() {
                  _isMenuHovered = true;
                });
              },
              onExit: (value) {
                setState(() {
                  _isMenuHovered = false;
                  _startMenuTimer();
                });
              },
              child: Material(
                elevation: 0,
                child: Column(
                  children: widget.items ??
                      [
                        Container(
                          height: (widget.filterList.length > (widget.maxShownItemCount ?? 8)) ? 350 : null,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Clr.whiteColor,
                          ),
                          child: Scrollbar(
                            thumbVisibility:
                                (widget.filterList.length > (widget.maxShownItemCount ?? 8)) ? true : false,
                            child: SingleChildScrollView(
                              physics: (widget.filterList.length > (widget.maxShownItemCount ?? 8))
                                  ? const BouncingScrollPhysics()
                                  : const NeverScrollableScrollPhysics(),
                              child: Column(
                                children: List.generate(widget.filterList.length, (index) {
                                  FilterModel element = widget.filterList[index];
                                  return ListTile(
                                    horizontalTitleGap: 5,
                                    leading: Obx(() {
                                      return Checkbox(
                                        value: element.isSelected.value,
                                        side: const BorderSide(width: .5),
                                        onChanged: (value) {
                                          onFilterChanged(
                                            index: index,
                                            value: value,
                                          );
                                          if (widget.onChanged != null) {
                                            widget.onChanged!();
                                          }
                                        },
                                      );
                                    }),
                                    title: Text(
                                      element.filterText,
                                      style: const TextStyle(
                                        fontSize: 13.5,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ),
                        )
                      ],
                ),
              ),
            ),
          );
        },
      );

      Overlay.of(context).insert(_overlayEntry!);
    }
  }

  void _hideMenu() {
    if (!_isButtonHovered && !_isMenuHovered && _overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }

  void _startMenuTimer() {
    _menuTimer = Timer(const Duration(milliseconds: 100), () {
      setState(() {
        _hideMenu();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (value) {
        setState(() {
          _isButtonHovered = true;
          _showMenu(context);
          _cancelMenuTimer();
        });
      },
      onExit: (value) {
        setState(() {
          _isButtonHovered = false;
          _startMenuTimer();
        });
      },
      child: widget.btnChild ??
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.btnText ?? "",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 5),
                    (_isButtonHovered == true || _isMenuHovered == true)
                        ? const Icon(Icons.keyboard_arrow_down_outlined)
                        : const Icon(Icons.keyboard_arrow_up_outlined)
                  ],
                ),
                Container(
                  height: 10,
                  width: 10,
                  color: Clr.transparentColor,
                ),
              ],
            ),
          ),
    );
  }

  void onFilterChanged({bool? value, required int index}) {
    debugPrint("onFilterChanged");
    // debugPrint("value: $value");
    // debugPrint("index: $index");

    if (value != null) {
      if (widget.isSingleSelection == true) {
        ///Logic for the Single Selection
        if (value == true) {
          for (int i = 0; i < widget.filterList.length; i++) {
            if (i == index) {
              widget.filterList[i].isSelected.value = value;
            } else {
              widget.filterList[i].isSelected.value = false;
            }
          }

          for (var element in widget.filterList) {
            if (widget.filterList[index] == element) {
              int? searchIndex = widget.selectedFilterList?.indexOf(widget.filterList[index]);

              if (searchIndex == -1 || searchIndex == null) {
                widget.selectedFilterList?.add(element);
              }
            } else {
              widget.selectedFilterList?.remove(element);
            }
          }
        } else {
          widget.filterList[index].isSelected.value = false;

          int? searchIndex = widget.selectedFilterList?.indexOf(widget.filterList[index]);

          if (searchIndex != -1 && searchIndex != null) {
            widget.selectedFilterList?.removeAt(searchIndex);
          }
        }
      } else {
        ///Logic for Multi Selection
        if (widget.filterList[index].isSelected.value != value) {
          widget.filterList[index].isSelected.value = value;
          if (value == true) {
            widget.selectedFilterList?.add(widget.filterList[index]);
          } else {
            int? searchIndex = widget.selectedFilterList?.indexOf(widget.filterList[index]);

            if (searchIndex != -1 && searchIndex != null) {
              widget.selectedFilterList?.removeAt(searchIndex);
            }
          }
        }
      }
    }
  }

  void _cancelMenuTimer() {
    if (_menuTimer != null && _menuTimer!.isActive) {
      _menuTimer!.cancel();
    }
  }
}
