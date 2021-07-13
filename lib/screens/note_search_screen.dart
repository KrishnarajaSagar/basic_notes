import 'package:basic_notes/boxes.dart';
import 'package:basic_notes/models/note_model.dart';
import 'package:basic_notes/providers/theme_provider.dart';
import 'package:basic_notes/screens/view_note_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class NoteSearch extends SearchDelegate<String> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          LineIcons.times,
          color: Theme.of(context).iconTheme.color,
        ),
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
      icon: Icon(
        LineIcons.arrowLeft,
        color: Theme.of(context).iconTheme.color,
      ),
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
        return query.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 18,
                    ),
                    const Icon(
                      LineIcons.binoculars,
                      color: Colors.grey,
                      size: 48,
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Text(
                      "Start typing to search notes",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.grey,
                          ),
                    )
                  ],
                ),
              )
            : buildNotes(context, suggestionNotes, suggestionNotesNumbers);
      },
    );
    throw UnimplementedError();
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context, listen: false);
    return provider.themeMode == ThemeMode.dark
        ? MyThemes.darkTheme.copyWith(
            textTheme: TextTheme(
              headline6: GoogleFonts.openSans(color: Colors.white),
              headline1: GoogleFonts.lora(color: Colors.white),
              bodyText1: GoogleFonts.openSans(color: Colors.white),
            ),
          )
        : MyThemes.lightTheme.copyWith(
            textTheme: TextTheme(
              headline6: GoogleFonts.openSans(color: Colors.black),
              headline1: GoogleFonts.lora(color: Colors.black),
              bodyText1: GoogleFonts.openSans(color: Colors.black),
            ),
          );
    throw UnimplementedError();
  }

  Widget buildNotes(
      BuildContext context, List<NoteModel> notes, List<int> notesNumbers) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 4,
        ),
        physics: const BouncingScrollPhysics(),
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
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          notes[index].title,
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.headline1!.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                      Container(
                        width: 30,
                        child: IconButton(
                          icon: Icon(
                            FontAwesomeIcons.bookmark,
                            color: Theme.of(context).colorScheme.background,
                            size: 18,
                          ),
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onPressed: () {},
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
                      style: Theme.of(context).textTheme.bodyText1,
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
