import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class CustomLoader extends StatelessWidget {
  final double? size;
  final double? customStrokeWidth;

  const CustomLoader({
    super.key,
    this.size,
    this.customStrokeWidth,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size ?? 28,
      height: size ?? 28,
      child: CircularProgressIndicator(
        strokeWidth: customStrokeWidth ?? 3,
        color: GashopperTheme.black,
      ),
    );
  }
}
