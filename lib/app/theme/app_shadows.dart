import 'package:flutter/material.dart';

abstract final class AppShadows {
  static const soft = [
    BoxShadow(
      color: Color(0x0D000000),
      blurRadius: 20,
      offset: Offset(0, 4),
    ),
  ];

  static const activeGlow = [
    BoxShadow(
      color: Color(0x330058BC),
      blurRadius: 24,
      offset: Offset(0, 8),
    ),
  ];
}
