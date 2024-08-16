import 'package:flutter/material.dart';

class CustomColors {
  CustomColors._();

  // Primary Color
  static const Color primaryColor = Color(0xFF4CAF50); // Bright green

  // Gradient Colors
  static const Gradient linearGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF4CAF50),
      Color(0xFF81C784),
      Color(0xFFC8E6C9),
    ],
    stops: [0.0, 0.5, 1.0],
  );

  // App Basic Colors
  static const Color primary = Color(0xFF4CAF50); // Updated to bright green
  static const Color secondary = Color(0xFFFFE24B); // Complementary yellow
  static const Color accent = Color(0xFFB3E5FC); // Soft blue for a calm look

  // Text Colors
  static const Color textPrimary = Color(0xFF333333); // Dark grey for readability
  static const Color textSecondary = Color(0xFF757575); // Lighter grey for secondary text
  static const Color textWhite = Colors.white; // White text

  // Background Colors
  static const Color light = Color(0xFFF6F6F6); // Very light grey for backgrounds
  static const Color dark = Color(0xFF212121); // Darker grey for contrast
  static const Color primaryBackground = Color(0xFFE8F5E9); // Very light green for the main background

  // Background Container Colors
  static const Color lightContainer = Color(0xFFFFFFFF); // White containers for contrast
  static Color darkContainer = CustomColors.dark.withOpacity(0.1); // Semi-transparent dark grey for containers

  // Button Colors
  static const Color buttonPrimary = Color(0xFF4CAF50); // Bright green for primary buttons
  static const Color buttonSecondary = Color(0xFF9E9E9E); // Neutral grey for secondary buttons
  static const Color buttonDisabled = Color(0xFFC4C4C4); // Light grey for disabled buttons

  // Border Colors
  static const Color borderPrimary = Color(0xFFD6D6D6); // Light grey for borders
  static const Color borderSecondary = Color(0xFFE0E0E0); // Slightly lighter grey for secondary borders

  // Error and Validation Colors
  static const Color error = Color(0xFFD32F2F); // Bright red for error
  static const Color success = Color(0xFF388E3C); // Green for success
  static const Color warning = Color(0xFFF57C00); // Orange for warning
  static const Color info = Color(0xFF1976D2); // Blue for information

  // Neutral Shades
  static const Color black = Color(0xFF000000); // Black for text or dark elements
  static const Color darkerGrey = Color(0xFF424242); // Dark grey
  static const Color darkGrey = Color(0xFF757575); // Medium grey
  static const Color grey = Color(0xFFBDBDBD); // Light grey
  static const Color softGrey = Color(0xFFE0E0E0); // Soft grey for subtle elements
  static const Color lightGrey = Color(0xFFF5F5F5); // Very light grey for backgrounds
  static const Color white = Color(0xFFFFFFFF); // White for text and backgrounds
}
