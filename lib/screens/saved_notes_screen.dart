import 'package:basic_notes/boxes.dart';
import 'package:basic_notes/models/note_model.dart';
import 'package:basic_notes/screens/view_note_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:basic_notes/widgets/side_drawer.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';

class SavedNotesScreen extends StatefulWidget {
  const SavedNotesScreen({Key? key}) : super(key: key);

  @override
  _SavedNotesScreenState createState() => _SavedNotesScreenState();
}

class _SavedNotesScreenState extends State<SavedNotesScreen> {
  List<int> savedNotesNumbers = [];
  List<NoteModel> savedNotes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Saved",
          style: Theme.of(context).textTheme.bodyText1,
        ),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(LineIcons.bars),
              onPressed: () => Scaffold.of(context).openDrawer(),
            );
          },
        ),
      ),
      drawer: SideDrawer(2),
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          content: Text("Press back again to exit"),
          behavior: SnackBarBehavior.floating,
        ),
        child: ValueListenableBuilder<Box<NoteModel>>(
          valueListenable: Boxes.getNotes().listenable(),
          builder: (context, box, _) {
            final notes = box.values.toList().cast<NoteModel>();
            savedNotes = notes.where((element) {
              return element.isPinned == true;
            }).toList();
            for (int i = 0; i < savedNotes.length; i++) {
              savedNotesNumbers.add(notes.indexOf(savedNotes[i]));
            }

            return savedNotes.isEmpty
                ? SizedBox.expand(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          LineIcons.snowflake,
                          size: 80,
                          color: Colors.grey,
                        ),
                        Text(
                          "Wow so empty!",
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                      ],
                    ),
                  )
                : buildNotes(
                    context,
                    savedNotes,
                    savedNotesNumbers,
                  );
          },
        ),
      ),
    );
  }

  Widget buildNotes(
      BuildContext context, List<NoteModel> notes, List<int> noteNumbers) {
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
                    noteNumbers[index],
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          notes[index].title,
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.headline6!.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                      Container(
                        width: 30,
                        child: IconButton(
                          icon: notes[index].isPinned == false
                              ? Icon(
                                  FontAwesomeIcons.bookmark,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  size: 18,
                                )
                              : Icon(
                                  FontAwesomeIcons.solidBookmark,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  size: 18,
                                ),
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onPressed: () {
                            setState(() {
                              notes[index].isPinned = !notes[index].isPinned;
                              final box = Boxes.getNotes();
                              NoteModel updatedNote = NoteModel(
                                title: notes[index].title,
                                body: notes[index].body,
                                isPinned: notes[index].isPinned,
                              );
                              box.putAt(noteNumbers[index], updatedNote);
                            });
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
