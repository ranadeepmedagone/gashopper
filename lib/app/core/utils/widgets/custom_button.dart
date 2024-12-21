import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Widget? rightIcon;
  final double borderRadius;
  final Function()? onPressed;
  final Color? customBackgroundColor;
  final TextStyle? customTextStyle;
  final BoxBorder? customBorderSide;
  final Widget? leftIcon;
  final bool isLeftIcon;
  final bool isRightIconEnd;
  final Color? customTextColor;
  final bool isDisable;
  final bool isLoading;
  const CustomButton({
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
    this.isDisable = false,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:
            customBackgroundColor ?? (isDisable ? Colors.grey[300] : GashopperTheme.appYellow),
        borderRadius: BorderRadius.circular(borderRadius),
        border: customBorderSide ?? Border.all(color: Colors.transparent),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius),
          onTap: isDisable ? null : onPressed,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
            child: Row(
              mainAxisAlignment:
                  isLeftIcon ? MainAxisAlignment.start : MainAxisAlignment.center,
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
                        color: customTextColor ??
                            (isDisable ? GashopperTheme.grey1 : GashopperTheme.black),
                      ),
                ),
                if (isLoading) const SizedBox(width: 8),
                if (isLoading)
                  const SizedBox(
                    height: 16,
                    width: 16,
                    child: CircularProgressIndicator(
                      color: GashopperTheme.black,
                      strokeWidth: 2,
                    ),
                  ),
                if (isRightIconEnd) const Spacer(),
                const SizedBox(width: 2),
                if (rightIcon != null) rightIcon!,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
