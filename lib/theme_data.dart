import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuickBillTheme {
  //Common primary Color for modes
  static const Color _primaryColor = Color(0xFF3E64FF);
  static const Color _secondaryColor = Color(0xFF5C6BC0);

  static final lightTheme = ThemeData(
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 2,
      foregroundColor: Colors.black,
    ),
    colorScheme: const ColorScheme.light(
      primary: _primaryColor, // main app color
      secondary: _secondaryColor,
      surface: Color(
        0xFFF1F5FB,
      ), // Light background for surfaces (Slightly off-white for better contrast)
      onPrimary: Colors.white, // text color on primary
      onSecondary: Colors.black, // text on background

      onSurface: Color(
        0xFF212121,
      ), // Darker text for surface areas (better contrast on cards)
      error: Color(0xFFFF3B30), // error message color
    ),
    scaffoldBackgroundColor: const Color(
      0xFFF5F7FA,
    ), // Soft off-white background for the whole page
    textTheme: GoogleFonts.poppinsTextTheme().apply(
      bodyColor: Color(0xFF212121), // Darker body text color
      displayColor: Color(0xFF212121), // Darker display text color
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: _primaryColor,
    ),
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF121212),
      foregroundColor: Colors.white,
    ),

    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: _primaryColor, // main app color
      secondary: _secondaryColor,

      surface: Color(
        0xFF2A2A2A,
      ), // Lighter dark gray for surface areas (Improved contrast)
      onPrimary: Colors.white, // text color on primary
      onSecondary: Colors.black, // text on background

      onSurface: Color.fromARGB(
        209,
        255,
        255,
        255,
      ), // Softer white for text on surface areas (less harsh)
      error: Color(0xFFFF453A), // error message color
    ),
    scaffoldBackgroundColor: const Color(0xFF121212), // Deep black background
    textTheme: GoogleFonts.poppinsTextTheme().apply(
      bodyColor: Colors.white70, // Softer white for body text
      displayColor: Colors.white70, // Softer white for display text
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: _secondaryColor,
    ),
  );
}
