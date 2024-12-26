import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:gashopper/app/core/utils/helpers.dart';

class CustomDropdownButton<T> extends StatelessWidget {
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final String hintText;
  final Function(T?)? onChanged;
  final Function(T?)? onSaved;
  final EdgeInsetsGeometry? padding;
  final TextStyle? hintStyle;
  final TextStyle? itemTextStyle;
  final BorderRadius? borderRadius;
  final double borderWidth;
  final Color borderColor;
  final Widget? icon;
  final double iconSize;
  final BoxShadow? dropdownShadow;
  final String? errorMessage;

  const CustomDropdownButton({
    super.key,
    this.value,
    required this.items,
    required this.hintText,
    this.onChanged,
    this.onSaved,
    this.padding,
    this.hintStyle,
    this.itemTextStyle,
    this.borderRadius,
    this.borderWidth = 1.5,
    this.borderColor = Colors.black,
    this.icon,
    this.iconSize = 24,
    this.dropdownShadow,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<T>(
      validator: (value) {
        if (value == null) {
          return errorMessage;
        }
        return null;
      },
      value: value,
      isExpanded: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(12),
          borderSide: BorderSide(
            color: borderColor,
            width: borderWidth,
          ),
        ),
        hintText: hintText,
        hintStyle: hintStyle ?? const TextStyle(fontSize: 14),
      ),
      items: items,
      onChanged: onChanged,
      onSaved: onSaved,
      iconStyleData: IconStyleData(
        icon: icon ?? const Icon(Icons.keyboard_arrow_down),
        iconSize: iconSize,
      ),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(6),
          boxShadow: dropdownShadow != null
              ? [dropdownShadow!]
              : [
                  BoxShadow(
                    color: Colors.grey.withAlphaOpacity(0.4),
                    offset: const Offset(0, 4),
                    blurRadius: 16,
                  ),
                ],
        ),
      ),
      menuItemStyleData: const MenuItemStyleData(height: 50),
    );
  }
}
