import 'package:flutter/material.dart';

import 'font_names.dart';
import 'main_colors.dart';

class MainAppTheme {
  ThemeData mainTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light()
        .copyWith(background: MainColors().backgroundPurple),
    fontFamily: "monreg",
    buttonTheme: ButtonThemeData(
      buttonColor: MainColors().buttonPink,
    ),
    textTheme: TextTheme(
      //White
      bodyLarge: TextStyle(
          color: MainColors().textWhite,
          fontSize: 28,
          fontFamily: FontNames().monst["reg"]),
      bodyMedium: TextStyle(
          color: MainColors().textWhite,
          fontSize: 16,
          fontFamily: FontNames().monst["reg"]),
      bodySmall: TextStyle(
          color: MainColors().textWhite,
          fontSize: 12,
          fontFamily: FontNames().ubu["bold"]),

      //Purple

      headlineSmall: TextStyle(
          color: MainColors().backgroundPurple,
          fontSize: 14,
          fontFamily: FontNames().pub["semibold"]),

      headlineMedium: TextStyle(
          color: MainColors().backgroundPurple,
          fontSize: 19,
          fontFamily: FontNames().ubu["bold"]),
      headlineLarge: TextStyle(
          color: MainColors().backgroundPurple,
          fontSize: 25,
          fontFamily: FontNames().monst["semibold"]),

      // Black
      labelMedium: TextStyle(
          color: MainColors().mainBlack,
          fontSize: 14,
          fontFamily: FontNames().monst["reg"]),
      labelLarge: TextStyle(
          color: MainColors().mainBlack,
          fontSize: 20,
          fontFamily: FontNames().pub["reg"]),

      //Muted
      displaySmall: TextStyle(
          color: MainColors().mutedTextSilver,
          fontSize: 17,
          fontFamily: FontNames().ubu["reg"]),
      displayMedium: TextStyle(
          color: MainColors().mutedTextSilver,
          fontSize: 20,
          fontFamily: FontNames().monst["semibold"]),
    ),
  );
}
