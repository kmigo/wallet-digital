import 'package:flutter/services.dart';


class CurrencyInputFormatter extends TextInputFormatter {

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
   if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    const int maxLength = 7;
    String newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (newText.length > maxLength) {
      newText = newText.substring(0, maxLength);
    }

    double value = double.parse(newText) / 100;
    String formattedValue = value.toStringAsFixed(2).replaceAll(".", ",");

    return newValue.copyWith(
      text: formattedValue,
      selection: TextSelection.collapsed(offset: formattedValue.length),
    );
  }
}
