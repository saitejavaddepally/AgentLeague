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
  final EdgeInsets? contentPadding;
  final TextStyle? style;
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
      this.hint,
      this.isDense,
      this.maxLength,
      this.style,
      this.contentPadding =
          const EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 10),
      Key? key})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextFormField(
        maxLength: maxLength,
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
          counterText: '',
          contentPadding: contentPadding,
          hintText: hint,
          hintStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Colors.white.withOpacity(0.3)),
          fillColor: Colors.white.withOpacity(0.1),
          filled: true,
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(borderRadius)),

        ),
      ),
    );
  }
}
