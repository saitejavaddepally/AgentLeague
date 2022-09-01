import 'package:flutter/material.dart';

class CustomSelector {
  final List dropDownItems;
  final void Function(dynamic)? onChanged;
  dynamic chosenValue;
  late Color color;
  late Color textColor;
  late Widget? hint;
  bool? isDense;
  late double height;
  final double borderRadius;

  CustomSelector({
    required this.dropDownItems,
    required this.onChanged,
    required this.chosenValue,
    this.borderRadius = 31,
    this.height = 40,
    this.isDense,
    this.hint,
    this.color = const Color(0xFF213C53),
    this.textColor = Colors.white,
  });

  use() {
    return DropdownButtonHideUnderline(
      child: ButtonTheme(
        alignedDropdown: true,
        child: DropdownButtonFormField(
            icon: const Icon(Icons.keyboard_arrow_down_outlined,
                color: Colors.red),
            dropdownColor: color,
            decoration: InputDecoration(
              isDense: isDense,
              fillColor: color,
              filled: true,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                  borderSide: BorderSide.none),
            ),
            items: dropDownItems
                .map((e) => DropdownMenuItem(
                    value: e, child: FittedBox(child: Text("$e"))))
                .toList(),
            validator: (value) => value == null ? 'Field Required' : null,
            hint: hint,
            value: chosenValue,
            isExpanded: true,
            style: TextStyle(
                fontWeight: FontWeight.w500, fontSize: 16, color: textColor),
            onChanged: onChanged),
      ),
    );
  }
}
