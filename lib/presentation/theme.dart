import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme {
  const CustomTheme({
    this.lightColor = const Color.fromARGB(255, 96, 59, 181),
    this.darkColor = const Color.fromARGB(255, 5, 99, 125),
  });

  final Color lightColor;
  final Color darkColor;

  ColorScheme _schemeLight() {
    return ColorScheme.fromSeed(seedColor: lightColor);
  }

  ColorScheme _schemeDark() {
    return ColorScheme.fromSeed(seedColor: darkColor, brightness: Brightness.dark);
  }

  ThemeData _base(final ColorScheme colorScheme) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: GoogleFonts.exoTextTheme(),
    );
  }

  ThemeData toThemeData() {
    final colorScheme = _schemeLight().toColorScheme(Brightness.light);
    return _base(colorScheme).copyWith(brightness: colorScheme.brightness);
  }

  ThemeData toThemeDataDark() {
    final colorScheme = _schemeDark().toColorScheme(Brightness.dark);
    return _base(colorScheme).copyWith(brightness: colorScheme.brightness);
  }
}

extension on ColorScheme {
  ColorScheme toColorScheme(Brightness brightness) {
    return ColorScheme(
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      outline: outline,
      outlineVariant: outlineVariant,
      background: background,
      onBackground: onBackground,
      surface: surface,
      onSurface: onSurface,
      surfaceVariant: surfaceVariant,
      onSurfaceVariant: onSurfaceVariant,
      inverseSurface: inverseSurface,
      onInverseSurface: onInverseSurface,
      inversePrimary: inversePrimary,
      shadow: shadow,
      scrim: scrim,
      surfaceTint: primary,
      brightness: brightness,
    );
  }
}
