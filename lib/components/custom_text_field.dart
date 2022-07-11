import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
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
      Key? key})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: TextFormField(
        maxLength: widget.maxLength,
        validator: widget.validator,
        onChanged: widget.onChanged,
        controller: widget.controller,
        onTap: widget.onTap,
        readOnly: widget.readOnly,
        keyboardType: widget.keyboardType,
        style: widget.style,
        cursorColor: Colors.white.withOpacity(0.1),
        decoration: InputDecoration(
          isDense: widget.isDense,
          suffixIcon: widget.icon,
          counterText: '',
          contentPadding: const EdgeInsets.symmetric(vertical: 9, horizontal: 5),
          hintText: widget.hint,
          hintStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Colors.white.withOpacity(0.3)),
          fillColor: Colors.white.withOpacity(0.1),
          filled: true,
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(widget.borderRadius)),
        ),
      ),
    );
  }
}
