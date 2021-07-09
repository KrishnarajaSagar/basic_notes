import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:basic_notes/models/note_model.dart';
import 'package:basic_notes/constants.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:basic_notes/boxes.dart';
import 'edit_note_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ViewNoteScreen extends StatefulWidget {
  final NoteModel currentNote;
  final int num;
  ViewNoteScreen(this.currentNote, this.num);

  @override
  State<ViewNoteScreen> createState() => _ViewNoteScreenState();
}

class _ViewNoteScreenState extends State<ViewNoteScreen> {
  @override
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
          buildPopupMenu(widget.num),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView(
          children: [
            Container(
              height: device.height / 7,
              child: Text(
                widget.currentNote.title,
                style: kTitleTextStyle.copyWith(
                  fontSize: 28,
                ),
              ),
            ),
            Text(
              widget.currentNote.body,
              style: kBodyTextStyle.copyWith(
                fontSize: 14,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPopupMenu(int num) {
    return PopupMenuButton(
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(
                  FontAwesomeIcons.bookmark,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "Pin",
                  style: kBodyTextStyle,
                ),
                const SizedBox(
                  width: 30,
                ),
              ],
            ),
          ),
          PopupMenuItem(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(FontAwesomeIcons.trash),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "Delete",
                  style: kBodyTextStyle,
                ),
                const SizedBox(
                  width: 30,
                ),
              ],
            ),
            onTap: () {
              deleteNote(num);
              Navigator.of(context).pop();
            },
          ),
        ];
      },
      color: kCardBGColor,
      icon: const Icon(LineIcons.verticalEllipsis),
    );
  }

  void deleteNote(int num) {
    final box = Boxes.getNotes();
    box.deleteAt(num);
  }
}
