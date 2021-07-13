import 'package:basic_notes/constants.dart';
import 'package:basic_notes/models/note_model.dart';
import 'package:basic_notes/providers/theme_provider.dart';
import 'package:basic_notes/screens/add_note_screen.dart';
import 'package:basic_notes/screens/view_note_screen.dart';
import 'package:flutter/material.dart';
import 'package:basic_notes/screens/notes_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:basic_notes/models/note_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(NoteModelAdapter());
  await Hive.openBox<NoteModel>('notes');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      builder: (context, _) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        return MaterialApp(
          title: 'Basic',
          debugShowCheckedModeBanner: false,
          themeMode: themeProvider.getTheme(themeProvider.isDarkMode),
          theme: MyThemes.lightTheme,
          darkTheme: MyThemes.darkTheme,
          home: NotesScreen(),
        );
      },
    );
  }
}
