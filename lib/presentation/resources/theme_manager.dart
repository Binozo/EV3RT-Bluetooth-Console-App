import 'package:ev3rt_bluetooth_console_app/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';

ThemeData getTheme() {
  return ThemeData(
    colorScheme: ColorScheme(
      primary: ColorManager.accent,
      background: ColorManager.primary,
      onBackground: ColorManager.primary,
      secondary: ColorManager.secondary,
      error: ColorManager.error,
      brightness: Brightness.dark,
      onPrimary: ColorManager.primary,
      onSecondary: ColorManager.secondary,
      onError: ColorManager.error,
      onSurface: ColorManager.accent,
      surface: ColorManager.primary,
    ),
    scaffoldBackgroundColor: ColorManager.primary,
    inputDecorationTheme: InputDecorationTheme(
      suffixIconColor: Colors.red,
      hintStyle: TextStyle(color: ColorManager.secondary),
      border: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.secondary)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.accent)),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.white)),
      fillColor: ColorManager.secondary,
      iconColor: Colors.white,
      floatingLabelStyle: TextStyle(color: ColorManager.accent),
      disabledBorder:
      OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
    ),
    dialogBackgroundColor: ColorManager.primary,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: ColorManager.accent,
        textStyle: TextStyle(color: ColorManager.primary, fontWeight: FontWeight.bold),
      ),
    ),
    textTheme: const TextTheme(
        subtitle1: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        subtitle2: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
        headline1: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 26,),
        headline2: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20,),
        headline3: TextStyle(color: Colors.white),
        headline4: TextStyle(color: Colors.white),
        headline5: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
  );
}