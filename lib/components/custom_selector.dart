import 'package:flutter/material.dart';

class CustomSelector {
  final List<String> _dropDownItems = ['abc', 'def'];
  String? _chosenValue;
  late Color color;
  late Color textColor;
  late bool dim;
  late String hint;

  CustomSelector(
      {this.color = const Color(0xFF213C53),
      this.textColor = Colors.white,
      this.dim = true,
      this.hint = 'All'});

  use() {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton<String>(
              icon: const Icon(Icons.keyboard_arrow_down_outlined,
                  color: Colors.red),
              dropdownColor: const Color(0xFF213C53),
              borderRadius: BorderRadius.circular(31),
              items: _dropDownItems
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              value: _chosenValue,
              hint: Text(hint,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: (dim) ? textColor.withOpacity(0.3) : textColor)),
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.3)),
              onChanged: (String? value) {}),
        ),
      ),
    );
  }
}
