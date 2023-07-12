import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Themes {
  final lighttheme = ThemeData(
    appBarTheme: AppBarTheme(color: Colors.red.shade900),
    primaryColor: Colors.red.shade900,
    fontFamily: GoogleFonts.poppins().fontFamily,
    // accentColor: Colors.red.shade900,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.red.shade900)
  );

  final darktheme = ThemeData.dark().copyWith(
    // scaffoldBackgroundColor: Colors.grey.shade900,
    appBarTheme: AppBarTheme(color: Colors.red.shade900),
  );
}

Color primaryColor = Colors.red.shade900;
