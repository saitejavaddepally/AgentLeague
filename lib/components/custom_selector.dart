import 'package:flutter/material.dart';

class CustomSelector<T> {
  final List dropDownItems;
  final void Function(dynamic)? onChanged;
  dynamic chosenValue;
  late Color color;
  late Color textColor;
  late Widget? hint;
  final double borderRadius;

  CustomSelector({
    required this.dropDownItems,
    required this.onChanged,
    required this.chosenValue,
    this.borderRadius = 31,
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
              fillColor: color,
              filled: true,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                  borderSide: BorderSide.none),
            ),
            items: dropDownItems
                .map((e) => DropdownMenuItem(value: e, child: Text("$e")))
                .toList(),
            validator: (value) => value == null ? 'Field Required' : null,
            hint: hint,
            value: chosenValue,
            style: TextStyle(
                fontWeight: FontWeight.w500, fontSize: 16, color: textColor),
            onChanged: onChanged),
      ),
    );
  }
}
