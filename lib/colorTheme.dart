import 'package:flutter/material.dart';

class AppThemes {
  static final Color lightMainColor = Color(0xFF670D2F);
  static final Color lightSecondColor = Color(0xFFA53860);

  static final Color darkMainColor = Color(0xff24242c);
  static final Color darkSecondColor = Color(0xFF393E46);

  static ThemeData get lightTheme => ThemeData(
    brightness: Brightness.light,
    primaryColor: lightMainColor,
    colorScheme: ColorScheme.light(
      primary: lightMainColor,
      secondary: lightSecondColor,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: lightMainColor,
      foregroundColor: Colors.white,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: lightSecondColor,
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: lightMainColor,
      selectionColor: lightSecondColor.withOpacity(0.5),
      selectionHandleColor: lightMainColor,
    ),
  );

  static ThemeData get darkTheme => ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: darkMainColor,
    primaryColor: darkMainColor,
    colorScheme: ColorScheme.dark(
      primary: darkMainColor,
      secondary: darkSecondColor,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: darkMainColor,
      foregroundColor: Colors.white,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: darkSecondColor,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.white70),
      bodyMedium: TextStyle(color: Colors.white70),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Colors.white,
      selectionColor: Colors.white38,
      selectionHandleColor: Colors.white,
    ),
  );
}
