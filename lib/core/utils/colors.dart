import 'package:flutter/material.dart';

/// Defines the application's color system with semantic naming and consistent progression.
/// Colors are organized to support both light and dark themes while maintaining
/// accessibility and visual hierarchy.
class AppColors {
  // Primary Colors (Blue)
  static const Color primary50 = Color(0xFFF0F7FF);
  static const Color primary100 = Color(0xFFE1F0FF);
  static const Color primary200 = Color(0xFFC3DFFF);
  static const Color primary300 = Color(0xFFA6C8FF);
  static const Color primary400 = Color(0xFF7EAAFF);
  static const Color primary500 = Color(0xFF4184E1); // Main primary color
  static const Color primary600 = Color(0xFF3470CC);
  static const Color primary700 = Color(0xFF2961B5);
  static const Color primary800 = Color(0xFF1B4B94);
  static const Color primary900 = Color(0xFF12397A);

<<<<<<< Updated upstream
  // Neutral Shades (Dark/Light Interchangeable)
  static const Color neutral100 = Color(0xFFFFFFFF); // White
  static const Color neutral500 = Color(0xFF0D0D12); // Dark
  static const Color neutral700 = Color(0xFF0A0A0E); // Slightly darker variant
  static const Color neutral900 = Color(0xFF08080A); // Deepest dark shade
=======
  // Neutral Colors (Bluish Black)
  static const Color neutral50 = Color(0xFFF8FAFC);
  static const Color neutral100 = Color(0xFFF1F5F9);
  static const Color neutral200 = Color(0xFFE2E8F0);
  static const Color neutral300 = Color(0xFFCBD5E1);
  static const Color neutral400 = Color(0xFF94A3B8);
  static const Color neutral500 = Color(0xFF697385); // Base neutral
  static const Color neutral600 = Color(0xFF475569);
  static const Color neutral700 = Color(0xFF334155);
  static const Color neutral800 = Color(0xFF1E293B);
  static const Color neutral900 =
      Color(0xFF0D0D12); // Darkest neutral (specified)
>>>>>>> Stashed changes

  // Surface Colors (Dark Theme)
  static const Color surfaceDark50 =
      Color(0xFF131316); // Slightly lighter than neutral900
  static const Color surfaceDark100 = Color(0xFF18181D);
  static const Color surfaceDark200 = Color(0xFF1D1D23);
  static const Color surfaceDark300 = Color(0xFF25252B);
  static const Color surfaceDark400 = Color(0xFF2D2D34);

  // Error Colors
  static const Color error50 = Color(0xFFFEF2F2);
  static const Color error100 = Color(0xFFFEE2E2);
  static const Color error300 = Color(0xFFFCA5A5);
  static const Color error500 = Color(0xFFEF4444);
  static const Color error700 = Color(0xFFB91C1C);
  static const Color error900 = Color(0xFF7F1D1D);

  // Success Colors
  static const Color success50 = Color(0xFFF0FDF4);
  static const Color success100 = Color(0xFFDCFCE7);
  static const Color success300 = Color(0xFF86EFAC);
  static const Color success500 = Color(0xFF22C55E);
  static const Color success700 = Color(0xFF15803D);
  static const Color success900 = Color(0xFF14532D);

  // Theme-Specific Semantic Colors
  static const Color backgroundLight = Color(0xFFFBFDFF);
  static const Color backgroundDark = neutral900;

  static const Color surfaceLight = Colors.white;
  static const Color surfaceDark = surfaceDark100;

  static const Color textPrimaryLight = neutral900;
  static const Color textPrimaryDark = neutral50;

  static const Color textSecondaryLight = neutral700;
  static const Color textSecondaryDark = neutral200;

  static const Color borderLight = neutral200;
  static const Color borderDark = surfaceDark300;

  // Overlay Colors
  static const Color overlayLight = Color(0x0A000000); // 4% black
  static const Color overlayDark = Color(0x0AFFFFFF); // 4% white

  // Shadow Colors
  static const Color shadowLight = Color(0x1A000000); // 10% black
  static const Color shadowDark = Color(0x1A000000); // 10% black

  // Status Colors
  static const Color success = success500;
  static const Color error = error500;
  static const Color warning = Color(0xFFFACC15);
  static const Color info = primary500;
}