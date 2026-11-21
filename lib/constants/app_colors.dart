import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF6366F1);   // indigo
  static const Color secondary = Color(0xFF4F46E5);  // darker indigo

  static const LinearGradient authGradient = LinearGradient(
    colors: [Color(0xFF6366F1), Color(0xFF4F46E5)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient dashboardGradient = LinearGradient(
    colors: [Color(0xFF6366F1), Color(0xFF4F46E5)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
