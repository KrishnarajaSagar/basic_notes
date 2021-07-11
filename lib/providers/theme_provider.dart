import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
    scaffoldBackgroundColor: const Color(0xff272121),
    colorScheme: const ColorScheme.dark(
      secondary: Color(0xffE16428),
      background: Color(0xff363333),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xff272121),
      centerTitle: true,
      elevation: 0,
      textTheme: TextTheme(
        headline6: GoogleFonts.openSans(fontSize: 16, color: Colors.white),
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
    ),
    textTheme: TextTheme(
      headline6: GoogleFonts.lora(color: Colors.white),
      bodyText1: GoogleFonts.openSans(color: Colors.white),
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Color(0xffE16428),
      selectionColor: Color(0xffE16428),
      selectionHandleColor: Color(0xffE16428),
    ),
    inputDecorationTheme: const InputDecorationTheme().copyWith(
      border: InputBorder.none,
      hintStyle: GoogleFonts.openSans(color: Colors.grey),
      labelStyle: GoogleFonts.openSans(color: Colors.white),
    ),
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xffffffff),
    colorScheme: const ColorScheme.light(
      secondary: Color(0xffE16428),
      background: Color(0xffF9F6F7),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xffffffff),
      centerTitle: true,
      elevation: 0,
      textTheme: TextTheme(
        headline6: GoogleFonts.openSans(fontSize: 16, color: Colors.black),
      ),
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
    ),
    textTheme: TextTheme(
      headline6: GoogleFonts.lora(color: Colors.black),
      bodyText1: GoogleFonts.openSans(color: Colors.black),
    ),
    iconTheme: const IconThemeData(
      color: Colors.black,
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Color(0xffE16428),
      selectionColor: Color(0xffE16428),
      selectionHandleColor: Color(0xffE16428),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: InputBorder.none,
      hintStyle: GoogleFonts.openSans(color: Colors.grey),
      labelStyle: GoogleFonts.openSans(color: Colors.black),
    ),
  );
}
