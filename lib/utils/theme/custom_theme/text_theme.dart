import 'package:flutter/material.dart';

class CustomTextTheme {
  CustomTextTheme._();

  static TextTheme lightTextTheme = const TextTheme(
    headlineLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700, color: Colors.black),
    headlineMedium: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700, color: Colors.black),
    headlineSmall: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.black),

    titleLarge: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500, color: Colors.black),
    titleMedium: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500, color: Colors.black),
    titleSmall: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w500, color: Colors.black),

    bodyLarge: TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal, color: Colors.black),
    bodyMedium: TextStyle(fontSize: 13.0, fontWeight: FontWeight.normal, color: Colors.black),
    bodySmall: TextStyle(fontSize: 11.0, fontWeight: FontWeight.normal, color: Colors.black),

    labelLarge: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.black),
    labelMedium: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: Colors.black),
  );

  static TextTheme darkTextTheme = const TextTheme(
    headlineLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700, color: Colors.white),
    headlineMedium: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700, color: Colors.white),
    headlineSmall: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.white),

    titleLarge: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500, color: Colors.white),
    titleMedium: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500, color: Colors.white),
    titleSmall: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w500, color: Colors.white),

    bodyLarge: TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal, color: Colors.white),
    bodyMedium: TextStyle(fontSize: 13.0, fontWeight: FontWeight.normal, color: Colors.white),
    bodySmall: TextStyle(fontSize: 11.0, fontWeight: FontWeight.normal, color: Colors.white),

    labelLarge: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.white),
    labelMedium: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: Colors.white),
  );
}
