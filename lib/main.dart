import 'package:basic_notes/constants.dart';
import 'package:basic_notes/models/note_model.dart';
import 'package:basic_notes/screens/add_note_screen.dart';
import 'package:basic_notes/screens/view_note_screen.dart';
import 'package:flutter/material.dart';
import 'package:basic_notes/screens/notes_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:basic_notes/models/note_model.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(NoteModelAdapter());
  await Hive.openBox<NoteModel>('notes');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
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
      ),
      //home: NotesScreen(),
      initialRoute: '/',
      routes: {
        '/': (context) => NotesScreen(),
      },
    );
  }
}
