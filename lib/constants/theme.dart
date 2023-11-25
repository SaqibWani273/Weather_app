import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme {
  // final textTheme = Theme.of(context).textTheme;
  ThemeData getTheme() {
    return ThemeData(
        textTheme: GoogleFonts.robotoTextTheme(ThemeData.light()
            .textTheme
            .copyWith(
                bodyMedium: GoogleFonts.roboto(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.w800))));
  }
}
