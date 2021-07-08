import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:basic_notes/constants.dart';
import 'package:hive/hive.dart';
import 'package:basic_notes/models/note_model.dart';
import 'package:basic_notes/boxes.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({Key? key}) : super(key: key);

  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  late String title;
  late String body;
  bool isPinned = false;
  @override
  Widget build(BuildContext context) {
    Size device = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit"),
        actions: [
          IconButton(
            icon: const Icon(LineIcons.save),
            onPressed: () {
              addNote(title, body, isPinned);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            Container(
              height: device.height / 7,
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Title",
                  hintStyle: kTitleTextStyle.copyWith(
                      fontSize: 28, color: Colors.grey),
                  border: InputBorder.none,
                ),
                style: kTitleTextStyle.copyWith(
                  fontSize: 28,
                ),
                onChanged: (String s) {
                  title = s;
                },
                cursorColor: Colors.white,
                maxLines: 3,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                textInputAction: TextInputAction.next,
              ),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "Let it flow...!",
                hintStyle: kBodyTextStyle.copyWith(
                  fontSize: 14,
                  color: Colors.grey,
                ),
                border: InputBorder.none,
              ),
              style: kBodyTextStyle.copyWith(
                fontSize: 14,
              ),
              onChanged: (String s) {
                body = s;
              },
              cursorColor: Colors.white,
              textCapitalization: TextCapitalization.sentences,
              keyboardType: TextInputType.multiline,
              //textInputAction: TextInputAction.newline,
              maxLines: null,
            ),
          ],
        ),
      ),
    );
  }

  void addNote(String title, String body, bool isPinned) {
    final note = NoteModel(
      title: title,
      body: body,
      isPinned: isPinned,
    );

    final box = Boxes.getNotes();
    box.add(note);
  }
}
