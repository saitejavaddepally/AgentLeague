import 'package:flutter/material.dart';

class CustomSelector extends StatelessWidget {
  final List dropDownItems;
  final void Function(dynamic)? onChanged;
  final dynamic chosenValue;
  final Color color;
  final Color textColor;
  final String hint;
  final bool isLead;
  final bool? isDense;
  final double height;
  final double borderRadius;

  const CustomSelector({
    Key? key,
    required this.dropDownItems,
    required this.onChanged,
    required this.chosenValue,
    this.borderRadius = 31,
    this.height = 40,
    this.isDense,
    this.hint = "",
    this.color = const Color(0xFF213C53),
    this.textColor = Colors.white,
    this.isLead = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: ButtonTheme(
        alignedDropdown: true,
        child: Theme(
          data: Theme.of(context).copyWith(
              canvasColor: color,
              inputDecorationTheme:
                  InputDecorationTheme(fillColor: color, filled: true)),
          child: DropdownButtonFormField(
              borderRadius: BorderRadius.circular(borderRadius),
              icon: const Icon(Icons.keyboard_arrow_down_outlined,
                  color: Colors.red),
              decoration: InputDecoration(
                isDense: isDense,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                    borderSide: BorderSide.none),
              ),
              items: dropDownItems
                  .map((e) => DropdownMenuItem(
                      value: e,
                      child: FittedBox(
                          child: (isLead)
                              ? Text(e.split('/')[0],
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .headline5)
                              : Text("$e",
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .headline5
                                      ?.copyWith(color: textColor)))))
                  .toList(),
              validator: (value) => value == null ? 'Field Required' : null,
              hint: Text(hint,
                  style: Theme.of(context).primaryTextTheme.headline6),
              value: chosenValue,
              isExpanded: true,
              style: Theme.of(context)
                  .primaryTextTheme
                  .headline5
                  ?.copyWith(color: textColor),
              onChanged: onChanged),
        ),
      ),
    );
  }
}
