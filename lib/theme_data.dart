import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuickBillTheme {
  static final lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF3E64FF),
      secondary: Color(0xFFFFA41B),
      background: Color(0xFFF7F9FC),
      surface: Colors.white,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onBackground: Color(0xFF212121),
      onSurface: Color(0xFF212121),
      error: Color(0xFFFF3B30),
    ),
    scaffoldBackgroundColor: const Color(0xFFF7F9FC),
    textTheme: GoogleFonts.poppinsTextTheme(),
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF3E64FF),
      secondary: Color(0xFFFFA41B),
      background: Color(0xFF121212),
      surface: Color(0xFF1E1E1E),
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onBackground: Colors.white,
      onSurface: Colors.white,
      error: Color(0xFFFF453A),
    ),
    scaffoldBackgroundColor: const Color(0xFF121212),
    textTheme: GoogleFonts.poppinsTextTheme(),
  );
}
