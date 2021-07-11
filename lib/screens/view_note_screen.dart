import 'package:basic_notes/screens/notes_screen.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:basic_notes/models/note_model.dart';
import 'package:basic_notes/constants.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:basic_notes/boxes.dart';
import 'edit_note_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ViewNoteScreen extends StatefulWidget {
  final NoteModel currentNote;
  final int num;
  ViewNoteScreen(this.currentNote, this.num);

  @override
  State<ViewNoteScreen> createState() => _ViewNoteScreenState();
}

class _ViewNoteScreenState extends State<ViewNoteScreen> {
  // @override
  // void initState() {
  //   Hive.openBox('notes');
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   Hive.close();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    Size device = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("View"),
        actions: [
          IconButton(
            icon: const Icon(LineIcons.edit),
            onPressed: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      EditNoteScreen(
                    widget.currentNote,
                    widget.num,
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
          ),
          IconButton(
            icon: const Icon(LineIcons.trash),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      title: Text(
                        "Confirm deletion?",
                        style: kBodyTextStyle,
                      ),
                      backgroundColor: kCardBGColor,
                      actions: [
                        TextButton(
                          child: Text(
                            "Cancel",
                            style: kBodyTextStyle,
                          ),
                          onPressed: () {},
                        ),
                        OutlinedButton(
                          child: Text(
                            "Confirm",
                            style: kBodyTextStyle.copyWith(color: Colors.red),
                          ),
                          onPressed: () {
                            //setState(() {
                            Navigator.of(context).pushAndRemoveUntil(
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        NotesScreen(),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  return SlideTransition(
                                    position: animation.drive(
                                      Tween(
                                        begin: const Offset(0, 1),
                                        end: const Offset(0, 0),
                                      ).chain(CurveTween(
                                          curve: Curves.easeOutCubic)),
                                    ),
                                    child: child,
                                  );
                                },
                              ),
                              (r) => false,
                            );
                            Fluttertoast.showToast(
                              msg: "Note deleted",
                              //toastLength: Toast.LENGTH_SHORT,
                              backgroundColor: kAccentColor,
                              textColor: Colors.white,
                            );
                            deleteNote(widget.num);
                            //});
                          },
                        ),
                      ],
                    );
                  });
            },
          ),
        ],
      ),
      body: ValueListenableBuilder<Box<NoteModel>>(
        valueListenable: Boxes.getNotes().listenable(),
        builder: (context, box, _) {
          final notes = box.values.toList().cast<NoteModel>();
          return buildNotes(context, notes, widget.num);
        },
      ),
    );
  }

  Widget buildNotes(BuildContext context, List<NoteModel> notes, int num) {
    try {
      Size device = MediaQuery.of(context).size;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Container(
              height: device.height / 7,
              child: Text(
                notes[widget.num].title,
                style: kTitleTextStyle.copyWith(
                  fontSize: 28,
                ),
              ),
            ),
            Text(
              notes[widget.num].body,
              style: kBodyTextStyle.copyWith(
                fontSize: 14,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      );
    } catch (e) {
      return const CircularProgressIndicator();
    }
  }

  void deleteNote(int num) {
    final box = Boxes.getNotes();
    box.deleteAt(num);
  }
}
