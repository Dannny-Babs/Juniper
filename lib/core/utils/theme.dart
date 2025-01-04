import 'package:flutter/material.dart';
import 'colors.dart';

class AppTheme {
  static final TextStyle _baseTextStyle = TextStyle(
    fontFamily: 'HelveticaNeue',
    letterSpacing: -0.24,
  );

  // Common theme elements
  static final _commonButtonTheme = ButtonThemeData(
    buttonColor: AppColors.primary500,
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    padding: const EdgeInsets.symmetric(
      horizontal: 24,
      vertical: 16,
    ),
    height: 52,
    minWidth: double.infinity,
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
  );

  static final _commonInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: BorderSide(
      color: const Color(0xFFEAECF0),
      width: 1.0,
    ),
  );

  static final _commonInputDecoration = InputDecorationTheme(
    hintStyle: _baseTextStyle.copyWith(
      color: AppColors.gray700,
    ),
  
    filled: true,
    border: _commonInputBorder,
    enabledBorder: _commonInputBorder,
    focusedBorder: _commonInputBorder.copyWith(
      borderSide: BorderSide(
        color: AppColors.neutral300,
        width: 1.5,
      ),
    ),
    labelStyle: TextStyle(
      fontFamily: 'HelveticaNeue',
      color: AppColors.neutral500,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: -0.1,
    ),
    floatingLabelStyle: TextStyle(
      color: AppColors.neutral500,
      fontFamily: 'HelveticaNeue',
      fontSize: 14,
      fontWeight: FontWeight.normal,
    
    ),
    contentPadding: const EdgeInsets.symmetric(
      vertical: 14.0,
      horizontal: 16.0,
    ),
    alignLabelWithHint: true,

  );

  static final ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.neutral500,
    highlightColor: AppColors.primary500,
    primaryColorDark: AppColors.neutral100,
    primaryColorLight: AppColors.neutral500,
    primarySwatch: Colors.blueGrey,
    colorScheme: ColorScheme.light(
      primary: AppColors.neutral500,
      secondary: AppColors.primary500,
      surface: AppColors.neutral100,
      error: AppColors.error500,
      onPrimary: AppColors.neutral100,
      onSecondary: AppColors.neutral100,
      onSurface: AppColors.neutral900,
      onError: AppColors.neutral100,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: AppColors.neutral100,
    fontFamily: 'HelveticaNeue',
    
    textTheme: TextTheme(
      displayLarge: _baseTextStyle.copyWith(
        fontSize: 32,
        fontWeight: FontWeight.w800,
        color: AppColors.gray300,
      ),
      displayMedium: _baseTextStyle.copyWith(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: AppColors.gray300,
      ),
      displaySmall: _baseTextStyle.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppColors.gray300,
      ),
      headlineLarge: _baseTextStyle.copyWith(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        color: AppColors.gray300,
      ),
      headlineMedium: _baseTextStyle.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: AppColors.gray300,
      ),
      headlineSmall: _baseTextStyle.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w300,
        color: AppColors.gray300,
      ),
      titleLarge: _baseTextStyle.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.gray300,
      ),
      titleMedium: _baseTextStyle.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.gray300,
      ),
      titleSmall: _baseTextStyle.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w300,
        color: AppColors.gray300,
      ),
      bodyLarge: _baseTextStyle.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.neutral500,  // Updated for input text
      ),
      bodyMedium: _baseTextStyle.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.neutral500,  // Updated for input text
      ),
      bodySmall: _baseTextStyle.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.gray300,
      ),
    ),
    buttonTheme: _commonButtonTheme.copyWith(
      colorScheme: ColorScheme(
        primary: AppColors.neutral500,
        onPrimary: Colors.white,
        secondary: AppColors.gray500,
        onSecondary: AppColors.neutral100,
        surface: AppColors.gray900,
        onSurface: AppColors.neutral100,
        error: AppColors.error500,
        onError: Colors.white,
        brightness: Brightness.light,
      ),
    ),
    inputDecorationTheme: _commonInputDecoration.copyWith(
      fillColor: Colors.white,
      activeIndicatorBorder: BorderSide(
        color: AppColors.neutral500,
        width: 1.5,
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.primary500,
    scaffoldBackgroundColor: AppColors.neutral900,
    fontFamily: 'HelveticaNeue',
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.neutral500,
      elevation: 0,
      titleTextStyle: _baseTextStyle.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: AppColors.neutral100,
      ),
    ),
    textTheme: TextTheme(
      displayLarge: _baseTextStyle.copyWith(
        fontSize: 32,
        fontWeight: FontWeight.w800,
        color: AppColors.neutral100,
      ),
      displayMedium: _baseTextStyle.copyWith(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: AppColors.neutral100,
      ),
      displaySmall: _baseTextStyle.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppColors.neutral100,
      ),
      headlineLarge: _baseTextStyle.copyWith(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        color: AppColors.neutral100,
      ),
      headlineMedium: _baseTextStyle.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: AppColors.neutral100,
      ),
      headlineSmall: _baseTextStyle.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w300,
        color: AppColors.neutral100,
      ),
      bodyLarge: _baseTextStyle.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.neutral500,  // Updated for input text
      ),
      bodyMedium: _baseTextStyle.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.neutral500,  // Updated for input text
      ),
      bodySmall: _baseTextStyle.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.neutral100,
      ),
      titleLarge: _baseTextStyle.copyWith(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: AppColors.neutral100,
      ),
      titleMedium: _baseTextStyle.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: AppColors.primary300,
      ),
      titleSmall: _baseTextStyle.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: AppColors.neutral100,
      ),
    ),
    buttonTheme: _commonButtonTheme.copyWith(
      colorScheme: ColorScheme(
        primary: AppColors.neutral500,
        onPrimary: Colors.white,
        secondary: AppColors.gray500,
        onSecondary: AppColors.neutral100,
        surface: AppColors.gray900,
        onSurface: AppColors.neutral100,
        error: AppColors.error500,
        onError: Colors.white,
        brightness: Brightness.dark,
      ),
    ),
    inputDecorationTheme: _commonInputDecoration.copyWith(
      fillColor: AppColors.neutral700,
      activeIndicatorBorder: BorderSide(
        color: AppColors.neutral100,
        width: 1.5,
      ),
    ),
  );
}