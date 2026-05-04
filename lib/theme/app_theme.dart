import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {

  // 🎨 COLORS (tema lama)
  static const Color bg = Color(0xFFF4F5FF);
  static const Color blue = Color(0xFF1565C0);
  static const Color dark = Color(0xFF102A72);
  static const Color green = Color(0xFF0E8A2A);

  // 🎯 GLOBAL THEME
  static ThemeData theme = ThemeData(
    useMaterial3: true,

    scaffoldBackgroundColor: bg,

    // font global
    textTheme: GoogleFonts.poppinsTextTheme().apply(
      bodyColor: dark,
      displayColor: dark,
    ),

    // appbar biar konsisten
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      foregroundColor: dark,
    ),

    // button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: blue,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),
    ),
  );
}