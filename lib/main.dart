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
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      builder: (context, _) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        return MaterialApp(
          title: 'Basic',
          debugShowCheckedModeBanner: false,
          themeMode: themeProvider.themeMode,
          theme: MyThemes.lightTheme,
          darkTheme: MyThemes.darkTheme,
          home: NotesScreen(),
        );
      },
    );
  }
}
