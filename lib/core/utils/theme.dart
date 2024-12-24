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
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.inter(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: AppColors.primary900,
        letterSpacing: -0.24,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppColors.primary700,
        letterSpacing: -0.24,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 16,
        color: AppColors.neutral700,
        letterSpacing: -0.24,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 14,
        color: AppColors.neutral500,
        letterSpacing: -0.24,
      ),
      labelLarge: GoogleFonts.inter(
        fontSize: 18,
        color: AppColors.neutral700,
        letterSpacing: -0.24,
      ),
      titleLarge: GoogleFonts.nunito(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: AppColors.primary500,
        letterSpacing: -0.24,
      ),
      titleMedium: GoogleFonts.nunito(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.primary700,
        letterSpacing: -0.24,
      ),
      titleSmall: GoogleFonts.nunito(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColors.primary700,
        letterSpacing: -0.24,
      ),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: AppColors.primary500,
      textTheme: ButtonTextTheme.primary,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.neutral100,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.buttonBorderRadius),
        borderSide: BorderSide.none,
      ),
      hintStyle: TextStyle(color: AppColors.neutral500),
    ),
  );

  // Define dark theme
  static final ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.primary500,
    scaffoldBackgroundColor: AppColors.neutral900,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.neutral900,
      elevation: 0,
      titleTextStyle: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.neutral100,
      ),
    ),
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.inter(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: AppColors.neutral100,
        letterSpacing: -0.24,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppColors.gray300,
        letterSpacing: -0.24,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 16,
        color: AppColors.neutral500,
        letterSpacing: -0.24,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 14,
        color: AppColors.neutral500,
        letterSpacing: -0.24,
      ),
      labelLarge: GoogleFonts.inter(
        fontSize: 18,
        color: AppColors.gray300,
        letterSpacing: -0.24,
      ),
      titleLarge: GoogleFonts.inter(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: AppColors.neutral100,
        letterSpacing: -0.24,
      ),
      titleMedium: GoogleFonts.nunito(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.gray300,
        letterSpacing: -0.24,
      ),
      titleSmall: GoogleFonts.nunito(
        fontSize: 18,
        fontWeight: FontWeight.bold,
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
      hintStyle: TextStyle(color: AppColors.neutral500),
    ),
  );
}
