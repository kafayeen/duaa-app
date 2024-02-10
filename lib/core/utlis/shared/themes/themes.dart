import 'package:duaa/core/utlis/primary_swatch.dart';
import 'package:duaa/core/utlis/shared/styles/styles.dart';
import 'package:flutter/material.dart';

class ThemeDuaa {
  static ThemeData themeDark = ThemeData(
    scaffoldBackgroundColor: StyleDuaa.scaffoldColorDark,
    brightness: Brightness.light,
    primaryColor: StyleDuaa.textsColorDark,
    primarySwatch: buildMaterialColor(StyleDuaa.textsColorDark),
    textTheme: TextTheme(
      bodyLarge: TextStyle(
          fontSize: StyleDuaa.styleChoose, color: StyleDuaa.textsColorDark),
      bodyMedium: TextStyle(
          fontSize: StyleDuaa.styleOnBoarding, color: StyleDuaa.textsColorDark),
      bodySmall: TextStyle(
          fontSize: StyleDuaa.styleButton, color: StyleDuaa.textsColorDark),
      titleLarge: TextStyle(
          fontSize: StyleDuaa.styleOfListTile, color: StyleDuaa.textsColorDark),
    ),
    primaryIconTheme: IconThemeData(color: StyleDuaa.textsColorDark),
  );
  static ThemeData themeLight = ThemeData(
      primaryIconTheme: IconThemeData(color: StyleDuaa.scaffoldColorDark),
      scaffoldBackgroundColor: StyleDuaa.textsColorDark,
      brightness: Brightness.dark,
      primaryColor: StyleDuaa.scaffoldColorDark,
      textTheme: TextTheme(
        bodyLarge: TextStyle(
            fontSize: StyleDuaa.styleChoose,
            color: StyleDuaa.scaffoldColorDark),
        bodyMedium: TextStyle(
            fontSize: StyleDuaa.styleOnBoarding,
            color: StyleDuaa.scaffoldColorDark),
        bodySmall: TextStyle(
            fontSize: StyleDuaa.styleButton,
            color: StyleDuaa.scaffoldColorDark),
        titleLarge: TextStyle(
            fontSize: StyleDuaa.styleOfListTile,
            color: StyleDuaa.scaffoldColorDark),
      ),
      primarySwatch: buildMaterialColor(StyleDuaa.scaffoldColorDark));
}
