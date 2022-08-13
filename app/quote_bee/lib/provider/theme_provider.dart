import 'package:flutter/material.dart';
import 'package:quote_bee/constants.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void changeTheme(bool isDark) {
    themeMode = isDark ? ThemeMode.light : ThemeMode.dark;
    // dont forget this
    notifyListeners();
  }
}

class Themes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: darkBlue,
    colorScheme: const ColorScheme.dark(),
    primaryColor: darkBlue,
    appBarTheme: AppBarTheme(
      backgroundColor: darkBlue,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontFamily: "LibreFranklin",
        foreground: Paint()..shader = linearGradientDark,
      ),
    ),
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(),
    primaryColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontFamily: "LibreFranklin",
        fontWeight: FontWeight.bold,
        foreground: Paint()..shader = linearGradientDark,
      ),
    ),
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
  );
}
