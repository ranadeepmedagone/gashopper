import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextStyle? hintStyle;
  final double borderRadius;
  final Color borderColor;
  final Color focusedBorderColor;
  final double borderWidth;
  final EdgeInsets contentPadding;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.hintStyle,
    this.borderRadius = 12.0,
    this.borderColor = Colors.grey,
    this.focusedBorderColor = Colors.blue,
    this.borderWidth = 1.5,
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 16,
    ),
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintStyle ??
           const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: borderColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: borderColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: focusedBorderColor,
            width: borderWidth,
          ),
        ),
        contentPadding: contentPadding,
      ),
    );
  }
}
