import 'package:flutter/services.dart';

class OneDotFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Check if the dot is at the beginning
    if (newValue.text.startsWith('.') && oldValue.text.isEmpty) {
      // If it's the first character, do not allow it
      return oldValue;
    }

    // Check if there are multiple dots in the text
    if (newValue.text.indexOf('.') != newValue.text.lastIndexOf('.')) {
      String trimText = "";

      for (int i = 0; i < newValue.text.toString().length; i++) {
        if (newValue.text.indexOf('.') != i) {
          trimText += newValue.text[i];
        }
      }

      return TextEditingValue(
        text: trimText,
        selection: TextSelection.collapsed(offset: trimText.length),
      );
    }

    // If none of the conditions apply, allow the input
    return newValue;
  }
}
