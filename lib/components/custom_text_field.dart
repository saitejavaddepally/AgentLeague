import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? Function(String?)? validator;
  final Widget? icon;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool readOnly;
  final double borderradius;
  const CustomTextField(
      {this.validator,
      this.onChanged,
      this.controller,
      this.onTap,
      this.keyboardType = TextInputType.text,
      this.readOnly = false,
      this.borderradius = 10,
      this.icon,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      onChanged: onChanged,
      controller: controller,
      onTap: onTap,
      readOnly: readOnly,
      keyboardType: keyboardType,
      cursorColor: Colors.white.withOpacity(0.1),
      decoration: InputDecoration(
        suffixIcon: icon,
        contentPadding: const EdgeInsets.all(10),
        hintText: "",
        hintStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Colors.white.withOpacity(0.3)),
        fillColor: Colors.white.withOpacity(0.1),
        filled: true,
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(borderradius)),
      ),
    );
  }
}
