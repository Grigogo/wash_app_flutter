import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData.light().copyWith(
  scaffoldBackgroundColor: const Color(0xFFEEF1F6),
  colorScheme: ThemeData.light().colorScheme.copyWith(
      primary: const Color(0xFF3DB0D4), secondary: const Color(0xFFFFFFFF)),

  // Стиль для SnackBar
  snackBarTheme: SnackBarThemeData(
    backgroundColor: const Color(0xFF3DB0D4), // Цвет фона SnackBar
    contentTextStyle: const TextStyle(
      fontSize: 16,
      color: Colors.white, // Цвет текста в SnackBar
    ),
    actionTextColor: Colors.yellow, // Цвет текста кнопок в SnackBar
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0), // Закругленные углы
    ),
    behavior: SnackBarBehavior.floating, // Плавающий стиль
    elevation: 6, // Тень
  ),

  inputDecorationTheme: const InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF3DB0D4)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
    ),
    floatingLabelStyle: TextStyle(color: Color(0xFF3DB0D4)),
    labelStyle: TextStyle(color: Color(0xFF111419)),
  ),

  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Color(0xFF3DB0D4),
    selectionColor: Color(0xFF3DB0D4),
    selectionHandleColor: Color(0xFF3DB0D4),
  ),

  appBarTheme: const AppBarTheme(
    color: Colors.white,
    iconTheme: IconThemeData(color: Color(0xFF111419)),
    titleTextStyle: TextStyle(color: Color(0xFF111419), fontSize: 20),
  ),

  buttonTheme: ButtonThemeData(
    buttonColor: const Color(0xFF3DB0D4),
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  ),

  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Color(0xFF111419)),
    bodyMedium: TextStyle(color: Color(0xFF111419)),
  ),

  iconTheme: const IconThemeData(
    color: Color(0xFF111419),
  ),

  cardTheme: CardTheme(
    color: Colors.white,
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  ),
);

//ТЕМНАЯ ТЕМА

final ThemeData darkTheme = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: const Color(0xFF111419),
  colorScheme: ThemeData.dark().colorScheme.copyWith(
      primary: const Color(0xFF3DB0D4), secondary: const Color(0xFF1E2229)),

  // Стиль для SnackBar
  snackBarTheme: SnackBarThemeData(
    backgroundColor: const Color(0xFF1E2229), // Цвет фона для темной темы
    contentTextStyle: const TextStyle(
      fontSize: 16,
      color: Colors.white, // Цвет текста в темной теме SnackBar
    ),
    actionTextColor: const Color(0xFF3DB0D4), // Цвет кнопок в темной теме
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0), // Закругленные углы
    ),
    behavior: SnackBarBehavior.floating, // Плавающий стиль
    elevation: 6, // Тень
  ),

  inputDecorationTheme: const InputDecorationTheme(
    filled: true,
    fillColor: Color(0xFF1E2229),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
    ),
    floatingLabelStyle: TextStyle(color: Color(0xFF3DB0D4)),
    labelStyle: TextStyle(color: Color(0xFFFFFFFF)),
  ),

  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Color(0xFF3DB0D4),
    selectionColor: Color(0xFF3DB0D4),
    selectionHandleColor: Color(0xFF3DB0D4),
  ),

  appBarTheme: const AppBarTheme(
    color: Color(0xFF1E2229),
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
  ),

  buttonTheme: ButtonThemeData(
    buttonColor: const Color(0xFF3DB0D4),
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  ),

  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white),
  ),

  iconTheme: const IconThemeData(
    color: Colors.white,
  ),

  cardTheme: CardTheme(
    color: const Color(0xFF1E2229),
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  ),
);
