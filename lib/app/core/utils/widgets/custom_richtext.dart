import 'package:flutter/material.dart';

/// Custom rich text widget displayed a single string where one section it is bold and the other is value not bold.
class CustomRichText extends StatelessWidget {
  const CustomRichText(
      {super.key,
      required this.headline,
      required this.value,
      this.leftCustomColor,
      this.leftCustomFontsize,
      this.rightCustomColor,
      this.rightCustomFontsize,
      this.leftCustomFontWeight,
      this.rightCustomFontWeight,
      this.customLetterSpacing,
      this.isGap = false,
      this.textAlign});

  /// Headline which is displayed in bold
  final String headline;

  /// Value to be displayed beside the headline
  final String value;

  final double? leftCustomFontsize;

  final double? rightCustomFontsize;

  final Color? leftCustomColor;

  final Color? rightCustomColor;

  final bool isGap;

  final FontWeight? leftCustomFontWeight;

  final FontWeight? rightCustomFontWeight;

  final double? customLetterSpacing;

  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: headline,
            style: TextStyle(
              fontWeight: leftCustomFontWeight ?? FontWeight.bold,
              fontSize: leftCustomFontsize ?? 16.0,
              color: leftCustomColor,
              letterSpacing: customLetterSpacing,
            ),
          ),
          if (isGap) const TextSpan(text: ' '),
          TextSpan(
            text: value,
            style: TextStyle(
              fontSize: rightCustomFontsize ?? 16.0,
              color: rightCustomColor,
              fontWeight: rightCustomFontWeight,
              letterSpacing: customLetterSpacing,
            ),
          ),
        ],
      ),
      textAlign: textAlign,
    );
  }
}
