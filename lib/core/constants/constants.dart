import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

/// A centralized class for managing app-wide constants.
class AppConstants {
  // Base API URL (if needed for future backend integration)
  static const String baseUrl = 'https://api.juniper.com';

  // Endpoints
  static const String apartmentListingsEndpoint = '$baseUrl/apartments';
  static const String userAuthEndpoint = '$baseUrl/auth';
  static const String userProfileEndpoint = '$baseUrl/users/profile';

  // Character Limit for User Input
  static const int maxDescriptionCharacters = 1000;

  // Error Messages
  static const String genericErrorMessage =
      'Something went wrong. Please try again later.';
  static const String networkErrorMessage =
      'Please check your internet connection and try again.';
  static const String passwordMismatchError = 'Passwords do not match';

  // Default Values
  static const String defaultApartmentImage = 'assets/images/default_apartment.jpg';

  // App Information
  static const String appName = 'Juniper';
  static const String appVersion = '1.0.0';

  // Padding and Margins
  static const double padding4 = 4.0;
  static const double padding8 = 8.0;
  static const double padding12 = 12.0;
  static const double padding16 = 16.0;
  static const double padding20 = 20.0;
  static const double padding24 = 24.0;
  static const double padding28 = 28.0;

  static const double margin4 = 4.0;
  static const double margin8 = 8.0;
  static const double margin12 = 12.0;
  static const double margin16 = 16.0;
  static const double margin20 = 20.0;
  static const double margin24 = 24.0;
  static const double margin28 = 28.0;

  // Animations
  static const Duration shortAnimationDuration = Duration(milliseconds: 200);
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
  static const Duration longAnimationDuration = Duration(milliseconds: 500);

  // Text and Typography
  static const double fontSizeSmall = 12.0;
  static const double fontSizeMedium = 16.0;
  static const double fontSizeLarge = 20.0;
  static const double fontSizeXLarge = 24.0;
  static const double fontSizeXXLarge = 32.0;

  static const double buttonBorderRadius = 12.0;

  // Shadow Configurations
  static const List<BoxShadow> defaultBoxShadow = [
    BoxShadow(
      color: Colors.black26,
      blurRadius: 4.0,
      offset: Offset(2, 2),
    ),
  ];

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF4184E1), Color(0xFF2961B5)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [Color(0xFF0D0D12), Color(0xFF08080A)],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [Color(0xFF4184E1), Color(0xFF12397A)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  // Icon Sizes
  static const double smallIconSize = 16.0;
  static const double mediumIconSize = 24.0;
  static const double largeIconSize = 32.0;
  static const double xLargeIconSize = 48.0;
}

// Validators
final passwordValidator = MultiValidator([
  RequiredValidator(errorText: 'Password is required'),
  MinLengthValidator(8,
      errorText: 'Password must be at least 8 characters long'),
  PatternValidator(r'(?=.*?[#?!@$%^&*-])',
      errorText: 'Password must have at least one special character')
]);

final emailValidator = MultiValidator([
  RequiredValidator(errorText: 'Email is required'),
  EmailValidator(errorText: "Enter a valid email address"),
]);

final usernameValidator = MultiValidator([
  RequiredValidator(errorText: 'Username is required'),
  MinLengthValidator(3,
      errorText: 'Username must be at least 3 characters long'),
]);

final descriptionValidator = MultiValidator([
  RequiredValidator(errorText: 'Description is required'),
  MaxLengthValidator(AppConstants.maxDescriptionCharacters,
      errorText:
          'Description must be less than ${AppConstants.maxDescriptionCharacters} characters long'),
]);
