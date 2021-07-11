import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle kTitleTextStyle = GoogleFonts.lora(
  color: Colors.white,
);
TextStyle kBodyTextStyle = GoogleFonts.openSans(
  color: Colors.white,
);
Color kAccentColor = const Color(0xffE16428);
Color kCardBGColor = const Color(0xff363333);

ThemeData backupThemeData = ThemeData.dark().copyWith(
  //primarySwatch: Colors.blue,
  appBarTheme: AppBarTheme(
    backgroundColor: const Color(0xff272121),
    centerTitle: true,
    elevation: 0,
    textTheme: TextTheme(
      headline6: GoogleFonts.openSans(fontSize: 16, color: Colors.white),
    ),
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: kAccentColor,
    selectionColor: kAccentColor,
    selectionHandleColor: kAccentColor,
  ),
  scaffoldBackgroundColor: const Color(0xff272121),
  accentColor: Colors.deepOrangeAccent,
);
