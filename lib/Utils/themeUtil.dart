import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
    primaryColor: Color(0xFF00c4cc),
    fontFamily: "Lato",
    textTheme: TextTheme(
        headline5: TextStyle(
            color: Colors.white,
            fontSize: 36.0,
            fontFamily: "NunitoSans Bold")),
    scaffoldBackgroundColor: Colors.grey.shade900,
    appBarTheme: AppBarTheme(
        color: Colors.grey.shade900,
        foregroundColor: Color(0xFFFBFCFD),
        iconTheme: IconThemeData(color: Colors.white)),
    colorScheme: ColorScheme.dark(),
  );

  static final lightTheme = ThemeData(
    primaryColor: Color(0xFF00c4cc),
    fontFamily: "Lato",
    textTheme: TextTheme(
        headline5: TextStyle(
            color: Colors.black,
            fontSize: 36.0,
            fontFamily: "NunitoSans Bold")),
    scaffoldBackgroundColor: Color(0xFFFBFCFD),
    appBarTheme: AppBarTheme(
        color: Color(0xFFFBFCFD),
        foregroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.black)),
    colorScheme: ColorScheme.light(),
  );
}
