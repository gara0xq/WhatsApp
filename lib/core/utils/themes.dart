import 'package:flutter/material.dart';
import 'colors.dart';

class Themes {
  static final light = ThemeData.light().copyWith(
    primaryColor: LightColors.primaryColor,
    colorScheme: ColorScheme.light(
      secondary: LightColors.secondaryColor,
      surface: LightColors.backgroundColor,
    ),
    appBarTheme: AppBarTheme(
      color: LightColors.appBarColor,
      iconTheme: IconThemeData(color: LightColors.iconColor),
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(color: LightColors.textColor),
      bodySmall: TextStyle(color: LightColors.textColor),
    ),
    iconTheme: IconThemeData(color: LightColors.iconColor),
    scaffoldBackgroundColor: LightColors.backgroundColor,
  );

  static final dark = ThemeData.dark().copyWith(
    primaryColor: DarkColors.primaryColor,
    colorScheme: ColorScheme.dark(
      secondary: DarkColors.secondaryColor,
      surface: DarkColors.backgroundColor,
    ),
    appBarTheme: AppBarTheme(
      color: DarkColors.appBarColor,
      iconTheme: IconThemeData(color: DarkColors.iconColor),
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(color: DarkColors.textColor),
      bodySmall: TextStyle(color: DarkColors.textColor),
    ),
    iconTheme: IconThemeData(color: DarkColors.iconColor),
    scaffoldBackgroundColor: DarkColors.backgroundColor,
  );
}
