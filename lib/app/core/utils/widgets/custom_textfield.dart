import 'package:flutter/material.dart';
import 'package:gashopper/app/core/theme/app_theme.dart';

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
  final Function()? onTap;
  final Function(String)? onChanged;
  final FocusNode? focusNode;
  final String? errorText;

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
    this.onTap,
    this.onChanged,
    this.focusNode,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        focusNode?.requestFocus();
      },
      child: TextField(
        onTap: onTap,
        onChanged: (value) {
          if (onChanged != null) {
            onChanged!(value);
          }
        },
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        focusNode: focusNode,
        decoration: InputDecoration(
          fillColor: GashopperTheme.appBackGrounColor,
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
          error: errorText != null
              ? Text(
                  errorText!,
                  style: const TextStyle(
                    color: GashopperTheme.red,
                    fontSize: 14,
                  ),
                )
              : null,
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: const BorderSide(
              color: GashopperTheme.red,
              width: 1,
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
      ),
    );
  }
}
