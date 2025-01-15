import 'package:flutter/material.dart';
import 'package:juniper/core/utils/utils.dart';

class AppTheme {
  // Base text style
  static final TextStyle _baseTextStyle = TextStyle(
    fontFamily: 'HelveticaNeue',
    letterSpacing: -0.24,
  );

  // Common elevation values
  static final _elevations = {
    'none': 0.0,
    'low': 2.0,
    'medium': 4.0,
    'high': 8.0,
  };

  // Helper method to build text theme
  static TextTheme _buildTextTheme(ColorScheme colorScheme) {
    final textColor = colorScheme.onSurface;

    return TextTheme(
      // Display styles
      displayLarge: _baseTextStyle.copyWith(
        fontSize: 32,
        fontWeight: FontWeight.w800,
        color: textColor,
        height: 1.2,
      ),
      displayMedium: _baseTextStyle.copyWith(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: textColor,
        height: 1.2,
      ),
      displaySmall: _baseTextStyle.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: textColor,
        height: 1.2,
      ),

      // Headline styles
      headlineLarge: _baseTextStyle.copyWith(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: textColor,
        height: 1.3,
      ),
      headlineMedium: _baseTextStyle.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: textColor,
        height: 1.3,
      ),
      headlineSmall: _baseTextStyle.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: textColor,
        height: 1.3,
      ),

      // Title styles
      titleLarge: _baseTextStyle.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: textColor,
        height: 1.4,
      ),
      titleMedium: _baseTextStyle.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: textColor,
        height: 1.4,
      ),
      titleSmall: _baseTextStyle.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: textColor,
        height: 1.4,
      ),

      // Body styles
      bodyLarge: _baseTextStyle.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textColor,
        height: 1.5,
      ),
      bodyMedium: _baseTextStyle.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: textColor,
        height: 1.5,
      ),
      bodySmall: _baseTextStyle.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: textColor,
        height: 1.5,
      ),
    );
  }

  // Helper method to build input decoration theme
  static InputDecorationTheme _buildInputDecorationTheme(
      ColorScheme colorScheme, bool isDark) {
    final borderRadius = BorderRadius.circular(12.0);
    final fillColor =
        isDark ? AppColors.surfaceDark100 : AppColors.surfaceLight;
    final borderColor =
        isDark ? AppColors.surfaceDark300 : AppColors.borderLight;

    return InputDecorationTheme(
      filled: true,
      fillColor: fillColor,

      // Border styling
      border: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: borderColor, width: 1.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: borderColor, width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: AppColors.primary500, width: 2.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: AppColors.error, width: 1.0),
      ),

      // Text styling
      labelStyle: TextStyle(
        fontFamily: 'HelveticaNeue',
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color:
            isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
      ),
      floatingLabelStyle: TextStyle(
        fontFamily: 'HelveticaNeue',
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: colorScheme.primary,
      ),
      hintStyle: TextStyle(
        fontFamily: 'HelveticaNeue',
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color:
            isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
      ),

      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      alignLabelWithHint: true,
      isDense: true,
    );
  }

  // Helper method to build bar theme
  static NavigationBarThemeData _buildNavigationBarTheme(
      ColorScheme colorScheme, bool isDark) {
    return NavigationBarThemeData(
      height: 165.h,
      elevation: 0,
      backgroundColor: isDark ? AppColors.surfaceDark100 : Colors.white,
      indicatorColor: Colors.transparent,
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        final TextStyle baseStyle = TextStyle(
          fontFamily: 'HelveticaNeue',
          letterSpacing: -0.1,
        );

        if (states.contains(WidgetState.selected)) {
          return baseStyle.copyWith(
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.primary500,
          );
        }

        return baseStyle.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.normal,
            color: isDark ? AppColors.textSecondaryDark : AppColors.neutral500);
      }),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        final color = states.contains(WidgetState.selected)
            ? AppColors.primary500
            : isDark
                ? AppColors.textSecondaryDark
                : AppColors.neutral500;

        return IconThemeData(color: color, size: 24);
      }),
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
    );
  }

  // Helper method to build card theme
  static CardTheme _buildCardTheme(ColorScheme colorScheme, bool isDark) {
    return CardTheme(
      color: isDark ? AppColors.surfaceDark100 : AppColors.surfaceLight,
      elevation: _elevations['low'],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isDark ? AppColors.surfaceDark300 : AppColors.borderLight,
          width: 1,
        ),
      ),
      shadowColor: isDark ? AppColors.shadowDark : AppColors.shadowLight,
      margin: const EdgeInsets.all(0),
    );
  }

  // Light Theme
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: AppColors.primary500,
      onPrimary: Colors.white,
      primaryContainer: AppColors.primary100,
      onPrimaryContainer: AppColors.primary900,
      secondary: AppColors.neutral500,
      onSecondary: Colors.white,
      secondaryContainer: AppColors.neutral100,
      onSecondaryContainer: AppColors.neutral900,
      surface: AppColors.surfaceLight,
      onSurface: AppColors.textPrimaryLight,
      surfaceContainerHighest: AppColors.neutral100,
      onSurfaceVariant: AppColors.textSecondaryLight,
      error: AppColors.error,
      onError: Colors.white,
      errorContainer: AppColors.error100,
      onErrorContainer: AppColors.error900,
      outline: AppColors.borderLight,
      shadow: AppColors.shadowLight,
    ),
    scaffoldBackgroundColor: AppColors.backgroundLight,
    cardTheme: _buildCardTheme(ColorScheme.light(), false),
    navigationBarTheme: _buildNavigationBarTheme(ColorScheme.light(), false),
    inputDecorationTheme:
        _buildInputDecorationTheme(ColorScheme.light(), false),
    textTheme: _buildTextTheme(ColorScheme.light()),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        elevation: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) return _elevations['none'];
          if (states.contains(WidgetState.hovered)) {
            return _elevations['medium'];
          }
          return _elevations['low'];
        }),
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.neutral200;
          }
          return AppColors.primary500;
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.neutral500;
          }
          return Colors.white;
        }),
      ),
    ),
  );

  // Dark Theme
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: AppColors.primary500,
      onPrimary: Colors.white,
      primaryContainer: AppColors.primary900,
      onPrimaryContainer: AppColors.primary100,
      secondary: AppColors.neutral900,
      onSecondary: Colors.white,
      secondaryContainer: AppColors.surfaceDark100,
      onSecondaryContainer: AppColors.textPrimaryDark,
      surface: AppColors.surfaceDark100,
      onSurface: AppColors.textPrimaryDark,
      surfaceContainerHighest: AppColors.surfaceDark300,
      onSurfaceVariant: AppColors.textSecondaryDark,
      outlineVariant: AppColors.borderDark,
      error: AppColors.error,
      onError: Colors.white,
      errorContainer: AppColors.error900,
      onErrorContainer: AppColors.error100,
      outline: AppColors.borderDark,
      shadow: AppColors.shadowDark,
    ),
    scaffoldBackgroundColor: AppColors.backgroundDark,
    cardTheme: _buildCardTheme(ColorScheme.dark(), true),
    inputDecorationTheme: _buildInputDecorationTheme(ColorScheme.dark(), true),
    textTheme: _buildTextTheme(ColorScheme.dark()),
    navigationBarTheme: _buildNavigationBarTheme(ColorScheme.dark(), true),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        elevation: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) return _elevations['none'];
          if (states.contains(WidgetState.hovered)) {
            return _elevations['medium'];
          }
          return _elevations['low'];
        }),
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.surfaceDark200;
          }
          return AppColors.primary500;
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.textSecondaryDark;
          }
          return Colors.white;
        }),
      ),
    ),
  );
}
