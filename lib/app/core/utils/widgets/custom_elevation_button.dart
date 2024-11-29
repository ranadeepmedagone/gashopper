import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class CustomElevatedButton extends StatelessWidget {
  final String title;
  final Widget? rightIcon;
  final double borderRadius;
  final VoidCallback onPressed;

  const CustomElevatedButton({
    super.key,
    required this.title,
     this.rightIcon,
    this.borderRadius = 12.0,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: GashopperTheme.appYellow,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.4,
                color: GashopperTheme.black,
              ),
            ),
            const SizedBox(width: 2),
            if (rightIcon != null) rightIcon!,
          ],
        ),
      ),
    );
  }
}
