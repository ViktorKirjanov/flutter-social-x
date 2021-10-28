import 'package:flutter/material.dart';

final theme = ThemeData(
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: const Color.fromRGBO(251, 239, 227, 1),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      labelStyle: const TextStyle(color: Colors.blue),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Colors.yellow,
          width: 2.0,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Colors.blue,
          width: 2.0,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: Colors.blue.shade900,
          width: 2.0,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: Colors.red.shade900,
          width: 2.0,
        ),
      ),
    ),
    // textSelectionTheme: TextSelectionThemeData(
    //   cursorColor: Colors.blue.shade700,
    //   selectionColor: Colors.blue.shade400,
    //   selectionHandleColor: Colors.blue.shade200,
    // ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        primary: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        side: const BorderSide(width: 2, color: Colors.blue),
      ),
    ));
