import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static TextTheme lightTexTheme = TextTheme(
    bodyText1: GoogleFonts.openSans(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    headline1: GoogleFonts.openSans(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    headline2: GoogleFonts.openSans(
      fontSize: 21,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    headline3: GoogleFonts.openSans(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  );

  static TextTheme darkTexTheme = TextTheme(
    bodyText1: GoogleFonts.openSans(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    headline1: GoogleFonts.openSans(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    headline2: GoogleFonts.openSans(
      fontSize: 21,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    headline3: GoogleFonts.openSans(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  );
  static light() {
    return ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: orange,
          //   secondary: Colors.purple,
          brightness: Brightness.light,
        ),
        textSelectionTheme: TextSelectionThemeData(selectionColor: lightGray),
        textTheme: lightTexTheme);
  }

  static dark() {
    return ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: orange,
          //   secondary: Colors.purple,
          brightness: Brightness.dark,
        ),
        textSelectionTheme:
             TextSelectionThemeData(selectionColor: AppTheme.orange),
        textTheme: lightTexTheme);
  }

  static Color orange = const Color(0xFFF7802A);
  static Color green = const Color(0XFF10483F);
  static Color gray = const Color(0XFFEDEDED);
  static Color lightGray = const Color(0XFF3F3939);
  static Color darkGray = const Color(0XFFC4C4C4);
}
