import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? Function(String?)? validator;
  final Widget? icon;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool readOnly;
  final double borderRadius;
  final String? hint;

  final bool? isDense;
  final int? maxLength;
  final int maxLines;
  final EdgeInsets? contentPadding;
  final TextStyle? style;
  final Color? fillColor;
  const CustomTextField(
      {this.validator,
      this.onChanged,
      this.controller,
      this.onTap,
      this.keyboardType = TextInputType.text,
      this.readOnly = false,
      this.borderRadius = 10,
      this.icon,
      this.maxLines = 1,
      this.hint,
      this.isDense = false,
      this.maxLength,
      this.style,
      this.fillColor,
      this.contentPadding =
          const EdgeInsets.only(left: 20, top: 10, bottom: 10),
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          inputDecorationTheme: Theme.of(context)
              .inputDecorationTheme
              .copyWith(fillColor: fillColor)),
      child: TextFormField(
        maxLength: maxLength,
        maxLines: maxLines,
        validator: validator,
        onChanged: onChanged,
        controller: controller,
        onTap: onTap,
        readOnly: readOnly,
        keyboardType: keyboardType,
        style: TextStyle(color: Theme.of(context).colorScheme.primary),
        cursorColor: Colors.white.withOpacity(0.1),
        decoration: InputDecoration(
          suffixIcon: icon,
          isDense: isDense,
          contentPadding: contentPadding,
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(borderRadius)),
          suffixIconConstraints:
              const BoxConstraints(minHeight: 40, minWidth: 40),
          counterText: '',
          hintText: hint,
        ),
      ),
    );
  }
}
