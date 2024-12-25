import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants.dart';
import 'colors.dart';

/// A utility class that defines the app's theme configuration.
///
/// Contains two main themes:
/// * [lightTheme] - The default light mode theme
/// * [darkTheme] - The dark mode theme configuration
///
/// Each theme defines consistent styling for:
/// * Colors
/// * Typography (using Inter and Nunito fonts)
/// * AppBar appearance
/// * Input decorations
/// * Button styles
class AppTheme {
  // Define light theme
  static final ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primary500,
    scaffoldBackgroundColor: AppColors.neutral100,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primary500,
      elevation: 0,
      titleTextStyle: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.neutral100,
      ),
    ),
    fontFamily: 'HelveticaNeue',
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w800, // Black
        color: AppColors.gray300,
        letterSpacing: -0.24,
      ),
      displayMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w700, // Heavy
        color: AppColors.gray300,
        letterSpacing: -0.24,
      ),
      displaySmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600, // Bold
        color: AppColors.gray300,
        letterSpacing: -0.24,
      ),
      headlineLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w500, // Medium
        color: AppColors.gray300,
        letterSpacing: -0.24,
      ),
      headlineMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400, // Roman
        color: AppColors.gray300,
        letterSpacing: -0.24,
      ),
      headlineSmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w300, // Light
        color: AppColors.gray300,
        letterSpacing: -0.24,
      ),
      titleLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400, // Roman
        color: AppColors.gray300,
        letterSpacing: -0.24,
      ),
      titleMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400, // Roman
        color: AppColors.gray300,
        letterSpacing: -0.24,
      ),
      titleSmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w300, // Light
        color: AppColors.gray300,
        letterSpacing: -0.24,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600, // Roman
        color: AppColors.gray300,
        letterSpacing: -0.24,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500, // Roman
        color: AppColors.gray300,
        letterSpacing: -0.24,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400, // Light
        color: AppColors.gray300,
        letterSpacing: -0.24,
      ),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: AppColors.primary500,
      textTheme: ButtonTextTheme.primary,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.neutral700,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.buttonBorderRadius),
        borderSide: BorderSide.none,
      ),
      hintStyle: TextStyle(
        fontFamily: 'HelveticaNeue',
        color: AppColors.neutral500,
      ),
    ),
  );

  // Dark Theme
  static final ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.primary500,
    scaffoldBackgroundColor: AppColors.neutral900,
    fontFamily: 'HelveticaNeue',
    
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.neutral500,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: AppColors.neutral100,
      ),
    ),
    
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: AppColors.neutral100,
        letterSpacing: -0.24,
      ),
      bodyMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: AppColors.neutral100,
        letterSpacing: -0.24,
      ),
      bodySmall: TextStyle(
        fontSize: 16,
        color: AppColors.gray300,
        
        letterSpacing: -0.24,
      ),
      labelSmall: TextStyle(
        fontSize: 14,
        color: AppColors.gray300,
        letterSpacing: -0.24,
      ),
      labelLarge: TextStyle(
        fontSize: 18,
        color: AppColors.gray300,
        letterSpacing: -0.24,
      ),
      titleLarge: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: AppColors.neutral100,
        letterSpacing: -0.24,
      ),
      titleMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: AppColors.primary300,
        letterSpacing: -0.24,
      ),
      titleSmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: AppColors.neutral100,
        letterSpacing: -0.24,
      ),
    ),
    
    buttonTheme: ButtonThemeData(
      buttonColor: AppColors.primary500,
      textTheme: ButtonTextTheme.primary,
    ),
    
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.neutral500,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.buttonBorderRadius),
        borderSide: BorderSide.none,
      ),
      hintStyle: TextStyle(color: AppColors.neutral700),
    ),
  );
}