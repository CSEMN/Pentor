import 'package:flutter/material.dart';

class Themes {
  static Color get primaryColor => const Color(0xff424874);
  static Color get accentColor => const Color(0xffA6B1E1);
  static Color get backgroundColor => const Color(0xffDCD6F7);
  static Color get canvasColor => const Color(0xffF4EEFF);

  // Light theme Data
  static ThemeData customLightTheme = ThemeData.light().copyWith(
    primaryColor: primaryColor,
    backgroundColor: backgroundColor,
    canvasColor: canvasColor,
    appBarTheme: AppBarTheme(
      color: primaryColor,
    ),
    // Button Themes
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
      shape: MaterialStateProperty.all<StadiumBorder>(
          StadiumBorder(side: BorderSide(color: primaryColor))),
    )),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(canvasColor),
        foregroundColor: MaterialStateProperty.all<Color>(primaryColor),
        shape: MaterialStateProperty.all<StadiumBorder>(
            StadiumBorder(side: BorderSide(color: primaryColor))),
      ),
    ),
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: Themes.primaryColor),
  );

  // Dark theme Data
  static ThemeData customDarkTheme = ThemeData.dark().copyWith(
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    backgroundColor: backgroundColor,
    appBarTheme: AppBarTheme(
      color: primaryColor,
    ),
    // Button Themes
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
      shape: MaterialStateProperty.all<StadiumBorder>(
          StadiumBorder(side: BorderSide(color: primaryColor, width: 5))),
    )),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(accentColor),
        shape: MaterialStateProperty.all<StadiumBorder>(
            StadiumBorder(side: BorderSide(color: primaryColor))),
      ),
    ),
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: Themes.primaryColor),
  );
}
