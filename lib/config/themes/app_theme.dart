import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/ui/colors.dart';
import '../../constants/ui/text_style.dart';
import '../../constants/ui/ui_parameters.dart';

enum AppTheme {
  light,
  dark,
}

final appThemeData = {
  AppTheme.light: ThemeData(
    useMaterial3: true,
    // fontFamily: GoogleFonts.libreFranklin().fontFamily,
    brightness: Brightness.light,
    indicatorColor: FColors.lightGreen,
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: FTextStyles.label,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 24.0,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: FColors.stroke,
          strokeAlign: StrokeAlign.outside,
        ),
        borderRadius: Ui.borderRadius,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: FColors.lightGreen,
          strokeAlign: StrokeAlign.outside,
        ),
        borderRadius: Ui.borderRadius,
      ),
      border: OutlineInputBorder(
        borderRadius: Ui.borderRadius,
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: Ui.borderRadius,
        borderSide: BorderSide(
          color: Colors.transparent,
          strokeAlign: StrokeAlign.outside,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(
          color: FColors.stroke,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: Ui.borderRadius,
        ),
      ),
    ),
    textSelectionTheme:
        const TextSelectionThemeData(cursorColor: FColors.lightGreen),
  ),
  AppTheme.dark: ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: GoogleFonts.libreFranklin().fontFamily,
  ),
};
