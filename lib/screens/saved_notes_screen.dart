import 'package:basic_notes/boxes.dart';
import 'package:basic_notes/constants.dart';
import 'package:basic_notes/models/note_model.dart';
import 'package:basic_notes/screens/view_note_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:basic_notes/widgets/side_drawer.dart';

class SavedNotesScreen extends StatefulWidget {
  const SavedNotesScreen({Key? key}) : super(key: key);

  @override
  _SavedNotesScreenState createState() => _SavedNotesScreenState();
}

class _SavedNotesScreenState extends State<SavedNotesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Saved"),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(LineIcons.bars),
              onPressed: () => Scaffold.of(context).openDrawer(),
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(LineIcons.search),
            onPressed: () {},
          ),
        ],
      ),
      drawer: SideDrawer(2),
      body: ValueListenableBuilder<Box<NoteModel>>(
        valueListenable: Boxes.getNotes().listenable(),
        builder: (context, box, _) {
          final notes = box.values.toList().cast<NoteModel>();
          Iterable<NoteModel> savedNotes;
          savedNotes = notes.where((element) {
            return element.isPinned == true;
          });
          List<NoteModel> savedNotesList = savedNotes.toList();
          return buildNotes(savedNotesList);
        },
      ),
    );
  }

  Widget buildNotes(List<NoteModel> notes) {
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
                    index,
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
                            setState(() {
                              notes[index].isPinned = !notes[index].isPinned;
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
