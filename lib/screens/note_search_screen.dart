import 'package:basic_notes/boxes.dart';
import 'package:basic_notes/constants.dart';
import 'package:basic_notes/models/note_model.dart';
import 'package:basic_notes/screens/view_note_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:line_icons/line_icons.dart';

class NoteSearch extends SearchDelegate<String> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(LineIcons.times),
        onPressed: () {
          query = "";
        },
      ),
    ];
    throw UnimplementedError();
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(LineIcons.arrowLeft),
      onPressed: () {
        close(context, "");
      },
    );
    throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ValueListenableBuilder<Box<NoteModel>>(
      valueListenable: Boxes.getNotes().listenable(),
      builder: (context, box, _) {
        final notes = box.values.toList().cast<NoteModel>();
        final List<int> suggestionNotesNumbers = [];
        final suggestionNotes = notes.where((element) {
          return (element.title.toLowerCase().contains(query) ||
              element.body.toLowerCase().contains(query));
        }).toList();
        for (int i = 0; i < suggestionNotes.length; i++) {
          suggestionNotesNumbers.add(notes.indexOf(suggestionNotes[i]));
        }
        return buildNotes(suggestionNotes, suggestionNotesNumbers);
      },
    );
    throw UnimplementedError();
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData.dark().copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: const Color(0xff272121),
        centerTitle: true,
        elevation: 0,
        textTheme: TextTheme(
          headline6: GoogleFonts.openSans(fontSize: 16, color: Colors.white),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme().copyWith(
        border: InputBorder.none,
        hintStyle: kBodyTextStyle.copyWith(color: Colors.grey),
        labelStyle: kBodyTextStyle,
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: kAccentColor,
        selectionColor: kAccentColor,
        selectionHandleColor: kAccentColor,
      ),
      scaffoldBackgroundColor: const Color(0xff272121),
      accentColor: Colors.deepOrangeAccent,
    );
    throw UnimplementedError();
  }

  Widget buildNotes(List<NoteModel> notes, List<int> notesNumbers) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 4,
        ),
        itemCount: notes.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      ViewNoteScreen(
                    notes[index],
                    notesNumbers[index],
                  ),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return SlideTransition(
                      position: animation.drive(
                        Tween(
                          begin: const Offset(1, 0),
                          end: const Offset(0, 0),
                        ).chain(CurveTween(curve: Curves.easeOutCubic)),
                      ),
                      child: child,
                    );
                  },
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: kCardBGColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          notes[index].title,
                          overflow: TextOverflow.ellipsis,
                          style: kTitleTextStyle.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Container(
                        width: 30,
                        child: IconButton(
                          icon: notes[index].isPinned == false
                              ? Icon(
                                  FontAwesomeIcons.bookmark,
                                  color: kAccentColor,
                                  size: 18,
                                )
                              : Icon(
                                  FontAwesomeIcons.solidBookmark,
                                  color: kAccentColor,
                                  size: 18,
                                ),
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onPressed: () {
                            notes[index].isPinned = !notes[index].isPinned;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Text(
                      notes[index].body,
                      overflow: TextOverflow.ellipsis,
                      style: kBodyTextStyle,
                      maxLines: 8,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
