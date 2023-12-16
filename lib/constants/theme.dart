import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme {
  // final textTheme = Theme.of(context).textTheme;
  ThemeData getTheme() {
    return ThemeData(
        appBarTheme:
            const AppBarTheme(iconTheme: IconThemeData(color: Colors.white)),
        textTheme: GoogleFonts.aBeeZeeTextTheme(ThemeData.light()
            .textTheme
            .copyWith(
                bodyMedium: GoogleFonts.aBeeZee(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.w800))));
  }
}
