import 'package:filehive/core/utils/styles_text.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

class CustomTheme {
  static ThemeData theme = ThemeData(
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: kSecondaryColor, foregroundColor: Colors.white),
    appBarTheme: const AppBarTheme(
      backgroundColor: kbackgroundColor,
      scrolledUnderElevation: 0,
    ),
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
      textStyle: WidgetStateProperty.all(
          const TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
      alignment: Alignment.center,
      shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
      foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
      backgroundColor: WidgetStateProperty.all<Color>(kPrimaryColor),
      overlayColor: WidgetStateProperty.resolveWith(
          (states) => transparentColor.withOpacity(0.2)),
    )),
    scaffoldBackgroundColor: kbackgroundColor,
    colorScheme: ColorScheme.fromSeed(
        seedColor: kPrimaryColor,
        primary: kPrimaryColor,
        secondary: kSecondaryColor),
    inputDecorationTheme: InputDecorationTheme(
      prefixIconColor: WidgetStateColor.resolveWith((states) {
        if (states.contains(WidgetState.error)) {
          return redColor;
        } else if (!states.contains(WidgetState.error) &&
            states.contains(WidgetState.focused)) {
          return kPrimaryColor;
        }
        return Colors.black;
      }),
      disabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: transparentColor)),
      fillColor: kbackgroundColor,
      filled: true,
      focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: redColor)),
      errorStyle: StylesText.textStyle14.copyWith(color: redColor),
      errorMaxLines: 3,
      errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: redColor)),
      border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: transparentColor, width: 1)),
      focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: kSecondaryColor, width: 1)),
      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      hintStyle: StylesText.textHint16,
    ),
    useMaterial3: true,
  );
}
