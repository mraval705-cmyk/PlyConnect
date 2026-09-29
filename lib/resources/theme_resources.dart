import 'package:flutter/material.dart';
import 'color_resources.dart';

/// The app theme is built here from the colours in [ColorResources].
///
/// Because this file only uses ColorResources, changing a colour in
/// ColorResources changes the app bar, the buttons and the background
/// everywhere at the same time.
class ThemeResources {
  static ThemeData get light {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: ColorResources.primary,
      brightness: Brightness.light,
    ).copyWith(
      primary: ColorResources.primary,
      surface: ColorResources.background,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: ColorResources.background,

      appBarTheme: const AppBarTheme(
        backgroundColor: ColorResources.background,
        foregroundColor: ColorResources.primary,
        elevation: 0,
        centerTitle: true,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorResources.primary,
          foregroundColor: ColorResources.white,
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: ColorResources.primary,
          side: const BorderSide(color: ColorResources.primary, width: 2),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: ColorResources.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: ColorResources.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: ColorResources.primary),
        ),
      ),
    );
  }
}
