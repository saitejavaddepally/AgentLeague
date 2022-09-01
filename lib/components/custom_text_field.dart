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
  final double height;
  final bool? isDense;
  final int? maxLength;
  final int maxLines;
  final EdgeInsets? contentPadding;
  final TextStyle? style;
  final Color fillColor;
  const CustomTextField(
      {this.validator,
      this.onChanged,
      this.controller,
      this.onTap,
      this.keyboardType = TextInputType.text,
      this.readOnly = false,
      this.borderRadius = 10,
      this.icon,
      this.height = 40,
      this.maxLines = 1,
      this.hint,
      this.isDense,
      this.maxLength,
      this.style,
      this.fillColor = const Color(0x0DFFFFFF),
      this.contentPadding =
          const EdgeInsets.only(left: 20, top: 10, bottom: 10),
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: maxLength,
      maxLines: maxLines,
      validator: validator,
      onChanged: onChanged,
      controller: controller,
      onTap: onTap,
      readOnly: readOnly,
      keyboardType: keyboardType,
      style: style,
      cursorColor: Colors.white.withOpacity(0.1),
      decoration: InputDecoration(
        isDense: isDense,
        suffixIcon: icon,
        suffixIconConstraints:
            const BoxConstraints(minHeight: 40, minWidth: 40),
        counterText: '',
        contentPadding: contentPadding,
        hintText: hint,
        hintStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Colors.white.withOpacity(0.3)),
        fillColor: fillColor,
        filled: true,
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(borderRadius)),
      ),
    );
  }
}
