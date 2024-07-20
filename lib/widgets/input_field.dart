import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberTextField extends StatelessWidget {
  const NumberTextField(
      {super.key,
      required this.labelString,
      required this.controller,
      required this.onChanged,
      required this.readOnly,
      required this.isDecimal,
      required this.isZeroToOne});

  final String labelString;
  final TextEditingController controller;
  final Function(String) onChanged;
  final bool readOnly;
  final bool isDecimal;
  final bool isZeroToOne;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        // Validation function for the name field
        if (value!.isEmpty && !readOnly) {
          return 'Field is required.'; // Return an error message if the name is empty
        }
        return null; // Return null if the name is valid
      },
      style: TextStyle(
          color: Colors.black
      ),
      readOnly: readOnly,
      enabled: !readOnly,
      onChanged: onChanged,
      cursorColor: const Color(0xff0642a2),
      cursorWidth: 1,
      controller: controller,
      decoration: InputDecoration(
        hintStyle: TextStyle(
          color: Colors.black
        ),
        labelText: labelString,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: const Color(0xff0642a2), width: 1.0),
        ),
        filled: !readOnly,
        fillColor: Colors.white,
      ),
      keyboardType: TextInputType.numberWithOptions(decimal: isDecimal),
      inputFormatters: [
        if (kIsWeb) FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
        if (!isDecimal) CustomRangeTextInputFormatter(minValue: 1),
        if (isZeroToOne) RangeTextInputFormatter(min: 0, max: 1)
      ],
    );
  }
}

class CustomRangeTextInputFormatter extends TextInputFormatter {
  final int minValue;

  CustomRangeTextInputFormatter({required this.minValue});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final int? value = int.tryParse(newValue.text);
    if (value == null || value < minValue) {
      return oldValue;
    }

    return newValue;
  }
}

class RangeTextInputFormatter extends TextInputFormatter {
  final double min;
  final double max;

  RangeTextInputFormatter({required this.min, required this.max});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Allow empty value
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // Try to parse the input value
    final double? value = double.tryParse(newValue.text);

    // If parsing fails or the value is out of range, return the old value
    if (value == null || value < min || value > max) {
      return oldValue;
    }

    // Otherwise, allow the new value
    return newValue;
  }
}
