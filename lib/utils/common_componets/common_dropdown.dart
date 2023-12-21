import 'package:admin_web_app/utils/validate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonDropDownButton extends StatelessWidget {
  const CommonDropDownButton({
    super.key,
    required this.selectedDropDownValue,
    this.dropdownList,
    this.items,
    this.onChanged,
    this.isNotEmpty,
    this.validator,
    this.isNotEmptyMessage,
  });

  final Rx<String?> selectedDropDownValue;
  final List<String>? dropdownList;
  final List<DropdownMenuItem<String>>? items;
  final void Function(String?)? onChanged;
  final bool? isNotEmpty;
  final String? isNotEmptyMessage;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Obx(() => DropdownButtonFormField<String>(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          value: selectedDropDownValue.value,
          elevation: 2,
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          borderRadius: BorderRadius.circular(10),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 7.0),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          ),
          hint: const Text("-- Select --"),
          items: items ??
              dropdownList?.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value.toString()),
                );
              }).toList(),
          onChanged: onChanged ??
              (String? newValue) {
                onDropDownChanged(newVal: newValue, value: selectedDropDownValue);
              },
          validator: (validator != null)
              ? validator
              : (isNotEmpty == true)
                  ? (value) {
                      if (value == null) {
                        return isNotEmptyMessage ?? ValidateStr.presetDropDownValidValidator;
                      }
                      return null;
                    }
                  : null,
        ));
  }

  void onDropDownChanged({String? newVal, required Rx<String?> value}) {
    debugPrint("onDropDownChanged -------------->");
    if (newVal != null) {
      debugPrint("newVal: $newVal");
      value.value = newVal;
    } else {
      debugPrint("DropDown Value is Null");
    }
  }
}
