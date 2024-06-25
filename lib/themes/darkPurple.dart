import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData dark_purple() {
    return ThemeData(
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: Color.fromARGB(255, 100, 10, 115),
        onPrimary: Colors.white,
        secondary: Color.fromARGB(255, 103, 12, 119),
        onSecondary: Colors.white,
        error: Colors.red,
        onError: Colors.white,
        surface: Colors.grey,
        onSurface: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        color: Color.fromARGB(255, 100, 10, 115),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          ),
        iconTheme: IconThemeData(color: Colors.white),
      )
    );
  }
}
