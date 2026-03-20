import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Cursor de mano para elementos interactuables en Windows/desktop.
final _clickCursor = WidgetStateProperty.all<MouseCursor>(SystemMouseCursors.click);

/// Colores de Filmaniak según el logo: verde lima y gris antracita.
class AppColors {
  /// Verde lima vibrante (elementos principales, botones, acentos)
  static const Color primary = Color(0xFFB8D936);
  static const Color primaryLow = Color(0xFF9ACD32);
  static const Color primaryAccent = Color(0xFFC8E65C);
  /// Gris antracita (fondos oscuros, texto, contraste)
  static const Color anthracite = Color(0xFF2C2C2E);
  static const Color anthraciteDark = Color(0xFF121212);
  /// Secundario / apoyo
  static const Color secondary = Color(0xFFE5A84B);
  static const Color secondaryLow = Color(0xFFFFB84B);
  static const Color red = Color(0xFFD50032);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey = Color(0xFF9E9E9E);
  static const Color surfaceLight = Color(0xFFFAFAFA);
  /// Superficie oscura (igual que Fitcron)
  static const Color surfaceDark = Color(0xFF121212);
}

ColorScheme get lightColorScheme {
  return const ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primary,
    onPrimary: AppColors.anthraciteDark,
    // Igual que Fitcron: colores "fijos" para que widgets externos (emoji picker, tabs, etc.)
    // no dependan de cómo derive Flutter `primaryFixed`.
    primaryFixed: AppColors.white,
    // 50% alpha del blanco (0x80)
    primaryFixedDim: const Color(0x80FFFFFF),
    secondary: AppColors.secondary,
    onSecondary: AppColors.black,
    tertiary: AppColors.primaryAccent,
    error: AppColors.red,
    onError: AppColors.white,
    surface: AppColors.surfaceLight,
    onSurface: AppColors.black,
  );
}

ColorScheme get darkColorScheme {
  return const ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.primary,
    onPrimary: AppColors.anthraciteDark,
    primaryFixed: AppColors.white,
    // 50% alpha del blanco (0x80)
    primaryFixedDim: const Color(0x80FFFFFF),
    secondary: AppColors.secondary,
    onSecondary: AppColors.black,
    tertiary: AppColors.primaryAccent,
    error: AppColors.red,
    onError: AppColors.white,
    surface: AppColors.surfaceDark,
    onSurface: AppColors.white,
  );
}

ThemeData themeFromColorScheme(ColorScheme colorScheme) {
  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: colorScheme.surface,
    // Estilos de hover/highlight para elementos tipo ListTile (ej. CheckboxListTile)
    hoverColor: colorScheme.tertiary.withValues(alpha: 0.3),
    highlightColor: colorScheme.tertiary.withValues(alpha: 0.3),
    hintColor: colorScheme.tertiary.withValues(alpha: 0.6),
    focusColor: colorScheme.secondary.withValues(alpha: 0.3),
    disabledColor: colorScheme.onSurface.withValues(alpha: 0.3),
    appBarTheme: AppBarTheme(
      backgroundColor: colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
      titleSpacing: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: colorScheme.primary,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: colorScheme.surface,
        systemNavigationBarIconBrightness:
            colorScheme.brightness == Brightness.dark
                ? Brightness.light
                : Brightness.dark,
      ),
    ),
    cardTheme: CardThemeData(
      color: colorScheme.brightness == Brightness.dark
          ? colorScheme.onSurface.withValues(alpha: 0.05)
          : colorScheme.surface,
      surfaceTintColor: colorScheme.tertiary,
      margin: const EdgeInsets.all(4),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: colorScheme.inverseSurface.withValues(alpha: 0.2),
        ),
      ),
    ),
    expansionTileTheme: ExpansionTileThemeData(
      iconColor: colorScheme.secondary,
      collapsedIconColor: colorScheme.onSurface,
      shape: const Border(),
    ),
    listTileTheme: ListTileThemeData(
      mouseCursor: _clickCursor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        mouseCursor: _clickCursor,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        mouseCursor: _clickCursor,
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return colorScheme.primary.withValues(alpha: 0.4);
          }
          return colorScheme.primary;
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return colorScheme.onPrimary.withValues(alpha: 0.6);
          }
          return colorScheme.onPrimary;
        }),
        padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        shape: WidgetStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        mouseCursor: _clickCursor,
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return colorScheme.onSurface.withValues(alpha: 0.4);
          }
          return colorScheme.onSurface;
        }),
        side: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return BorderSide(color: colorScheme.primary.withValues(alpha: 0.3));
          }
          return BorderSide(color: colorScheme.primary);
        }),
        padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        shape: WidgetStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      filled: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    ),
    switchTheme: SwitchThemeData(
      // Evitamos que el thumb cambie a un color raro al pasar el ratón
      // (hover) en desktop/web.
      trackOutlineColor: WidgetStateProperty.resolveWith<Color?>((states) {       
        if (states.contains(WidgetState.disabled)) {
          return colorScheme.onSurface.withValues(alpha: 0.1);
        } else if (states.contains(WidgetState.selected)) {
          return colorScheme.primary;
        }
        return null; // fallback a Flutter por defecto
      }),
      trackColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.disabled)) {
          return colorScheme.onSurface.withValues(alpha: 0.3);
        } else if (states.contains(WidgetState.selected)) {
          return colorScheme.primary.withValues(alpha: 0.3);
        }       
        return null; // fallback a Flutter por defecto
      }),
      thumbColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.disabled)) {
          return colorScheme.primary.withValues(alpha: 0.3);
        } else if (states.contains(WidgetState.selected)) {
          return colorScheme.primary;
        }        
        return null; // fallback a Flutter por defecto
      }),      
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      mouseCursor: _clickCursor,
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(mouseCursor: _clickCursor),
    ),
    dialogTheme: DialogThemeData(
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurface,
      ),
      contentTextStyle: TextStyle(
        fontSize: 16,
        color: colorScheme.onSurface,
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: colorScheme.inverseSurface,
      contentTextStyle: TextStyle(color: colorScheme.onInverseSurface),
      //behavior: SnackBarBehavior.fixed,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
    ),
  );
}

ThemeData get lightTheme => themeFromColorScheme(lightColorScheme);
ThemeData get darkTheme => themeFromColorScheme(darkColorScheme);
