import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


class GashopperTheme {

  static TextStyle fontWeightApplier(FontWeight fw, TextStyle ts) {
    return ts.merge(GoogleFonts.nunitoSans(
      fontWeight: fw,
    ));
  }

  static mainTheme() {
    final textTheme = Get.textTheme;
    return ThemeData(
      useMaterial3: false,
      appBarTheme: const AppBarTheme(color: Color(0xFF0B6FE4)),
      primaryColor:const Color(0xFF0B6FE4),
      primaryColorDark:const Color(0xFF0B6FE4),
      primaryColorLight:const Color(0xFF0B6FE4),
      textTheme: GoogleFonts.nunitoSansTextTheme(
        textTheme
            .apply(
              bodyColor: Colors.grey[800],
              displayColor: Colors.grey[800],
            )
            .copyWith(
              bodyLarge: textTheme.bodyLarge!.copyWith(
                fontSize: 16.0,
              ),
            ),
      ),
      inputDecorationTheme:const InputDecorationTheme(
        fillColor: Color(0xFFF2F5FA),
        contentPadding: EdgeInsets.fromLTRB(16, 18, 16, 18),
      ),
      buttonTheme: ButtonThemeData(
        height: 56.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: const Color(0xFFFF8133),
      ),
    );
  }

  final hyperlinkText = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.underline,
    color: Colors.blue,
  );

  static const appBackGrounColor = Color(0xFFFAFAFA);
  static const appYellow = Color(0xFFffc800);
 
  static const black = Color(0xFF000000);
  static const black1 = Color(0xff333333);
  static const black2 = Color(0xFF090A0A);

  // Yellows
  static const yellow2 = Color(0xFFfac03a);
  static const yellow3 = Color(0xFFFEDC00);

  static const grey1 = Color(0xFF6D6A6A);


  
}
