import 'package:flutter/material.dart';

abstract final class AppTypography {
  static TextTheme textTheme(Color color) => TextTheme(
        displayLarge: TextStyle(
          fontFamily: 'Inter',
          fontSize: 48,
          height: 56 / 48,
          fontWeight: FontWeight.w700,
          color: color,
        ),
        headlineLarge: TextStyle(
          fontFamily: 'Inter',
          fontSize: 32,
          height: 40 / 32,
          fontWeight: FontWeight.w600,
          color: color,
        ),
        headlineMedium: TextStyle(
          fontFamily: 'Inter',
          fontSize: 24,
          height: 32 / 24,
          fontWeight: FontWeight.w600,
          color: color,
        ),
        titleMedium: TextStyle(
          fontFamily: 'Inter',
          fontSize: 17,
          height: 24 / 17,
          fontWeight: FontWeight.w600,
          color: color,
        ),
        bodyLarge: TextStyle(
          fontFamily: 'Inter',
          fontSize: 17,
          height: 24 / 17,
          color: color,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'Inter',
          fontSize: 15,
          height: 20 / 15,
          color: color,
        ),
        labelSmall: TextStyle(
          fontFamily: 'Inter',
          fontSize: 12,
          height: 16 / 12,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      );
}
