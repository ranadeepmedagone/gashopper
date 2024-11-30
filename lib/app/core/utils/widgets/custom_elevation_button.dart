import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class CustomElevatedButton extends StatelessWidget {
  final String title;
  final Widget? rightIcon;
  final double borderRadius;
  final VoidCallback onPressed;
  final Color? customBackgroundColor;
  final TextStyle? customTextStyle;
  final BorderSide? customBorderSide;
  final Widget? leftIcon;
  final bool isLeftIcon;
  final bool isRightIconEnd;
  final Color? customTextColor;

  const CustomElevatedButton({
    super.key,
    required this.title,
    this.rightIcon,
    this.borderRadius = 12.0,
    this.customBackgroundColor,
    this.customTextStyle,
    this.customBorderSide,
    this.leftIcon,
    this.isLeftIcon = false,
    this.isRightIconEnd = false,
    this.customTextColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: customBackgroundColor ?? GashopperTheme.appYellow,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: customBorderSide ?? BorderSide.none,
          ),
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        ),
        child: Row(
          mainAxisAlignment: isLeftIcon ? MainAxisAlignment.start : MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (leftIcon != null) leftIcon!,
            const SizedBox(width: 2),
            Text(
              title,
              style: customTextStyle ??
                  TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                    color: customTextColor ?? GashopperTheme.black,
                  ),
            ),
            if (isRightIconEnd) const Spacer(),
            const SizedBox(width: 2),
            if (rightIcon != null) rightIcon!,
          ],
        ),
      ),
    );
  }
}
