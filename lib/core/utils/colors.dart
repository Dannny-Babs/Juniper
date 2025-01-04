import 'package:flutter/material.dart';


/// A class that defines the color constants used in the app with Tailwind-inspired naming.


class AppColors {
  // Primary Shades (Blue)
  static const Color primary100 = Color(0xFFE1F0FF); // Lighter shade of primary
  static const Color primary300 = Color(0xFFA6C8FF); // Medium shade of primary
  static const Color primary500 = Color(0xFF4184E1); // Main primary color
  static const Color primary700 = Color(0xFF2961B5); // Darker shade of primary
  static const Color primary900 = Color(0xFF12397A); // Deepest primary shade

  // Neutral Shades (Dark/Light Interchangeable)
  static const Color neutral100 = Color(0xFFFFFFFF); // White
  static const Color neutral300 = Color(0xFF15172A); // Lighter shade of neutral  
  static const Color neutral500 = Color(0xFF0D0D12); // Dark
  static const Color neutral700 = Color(0xFF0A0A0E); // Slightly darker variant
  static const Color neutral900 = Color(0xFF08080A); // Deepest dark shade

  // Gray Shades
  static const Color gray100 = Color(0xFFF9F9F9);
  static const Color gray300 = Color(0xFFE0E0E0);
  static const Color gray500 = Color(0xFF8F8F8F);
  static const Color gray700 = Color(0xFF4A4A4A);
  static const Color gray900 = Color(0xFF1C1C1C);

  // Accent Shades
  static const Color accent100 = Color(0xFFE6F7FF); // Very light accent
  static const Color accent300 = Color(0xFF99DFFF); // Medium accent
  static const Color accent500 = Color(0xFF33C4FF); // Main accent
  static const Color accent700 = Color(0xFF009BCC); // Darker accent
  static const Color accent900 = Color(0xFF007399); // Deepest accent shade

  // Error Colors
  static const Color error500 = Color(0xFFFF4D4D); // Standard error color
  static const Color error700 = Color(0xFFE63333); // Slightly darker error
  static const Color error900 = Color(0xFFB32424); // Deepest error shade
}
