import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class GashopperTheme {
  static TextStyle fontWeightApplier(FontWeight fw, TextStyle ts) {
    return GoogleFonts.nunitoSans(
      textStyle: ts,
      fontWeight: fw,
    );
  }

  static ThemeData mainTheme() {
    return ThemeData(
      useMaterial3: false,
      appBarTheme: const AppBarTheme(
        color: Color(0xFF0B6FE4),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      primaryColor: const Color(0xFF0B6FE4),
      primaryColorDark: const Color(0xFF0B6FE4),
      primaryColorLight: const Color(0xFF0B6FE4),
      textTheme: GoogleFonts.nunitoSansTextTheme(
        ThemeData.light().textTheme.copyWith(
              bodyLarge: const TextStyle(
                fontSize: 16.0,
                color: Color(0xFF4A4A4A),
              ),
              bodyMedium: const TextStyle(
                fontSize: 14.0,
                color: Color(0xFF4A4A4A),
              ),
              titleMedium: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: Color(0xFF4A4A4A),
              ),
            ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        fillColor: Color(0xFFF2F5FA),
        filled: true,
        contentPadding: EdgeInsets.fromLTRB(16, 18, 16, 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide.none,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: const Color(0xFFFF8133),
      ),
    );
  }

  static const appBackGrounColor = Color(0xFFFAFAFA);
  static const appYellow = Color(0xFFFFC600);
  static const black = Color(0xFF2B363C);

  static const black1 = Color(0xff333333);
  static const black2 = Color(0xFF090A0A);

  static const yellow2 = Color(0xFFfac03a);
  static const yellow3 = Color(0xFFFEDC00);

  static const grey1 = Color(0xFF6D6A6A);
  static const grey2 = Color(0xFFEBEDF0);

  static const red = Color(0xFFFB4C4C);
}
