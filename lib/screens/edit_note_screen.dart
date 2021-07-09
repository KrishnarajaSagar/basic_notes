import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:line_icons/line_icons.dart';
import 'package:basic_notes/constants.dart';
import 'package:basic_notes/models/note_model.dart';
import 'package:basic_notes/boxes.dart';

class EditNoteScreen extends StatefulWidget {
  final NoteModel currentNote;
  int num;
  EditNoteScreen(this.currentNote, this.num);

  @override
  _EditNoteScreenState createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  String? title;
  String? body;
  bool isPinned = false;

  // final TextEditingController titleController =
  // TextEditingController(text: widget.currentNote.title);
  // final TextEditingController bodyController =
  // TextEditingController(text: widget.currentNote.body);

  // @override
  // void dispose() {
  //   title
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    Size device = MediaQuery.of(context).size;
    title = widget.currentNote.title;
    body = widget.currentNote.body;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit"),
        actions: [
          IconButton(
            icon: const Icon(LineIcons.save),
            onPressed: () {
              editNote(title!, body!, isPinned, widget.num);
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
              child: TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Title",
                  hintStyle: kTitleTextStyle.copyWith(
                      fontSize: 28, color: Colors.grey),
                ),
                //controller: titleController,
                style: kTitleTextStyle.copyWith(
                  fontSize: 28,
                ),
                onChanged: (String s) {
                  title = s;
                },
                initialValue: title,
                cursorColor: Colors.white,
                maxLines: 3,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                textInputAction: TextInputAction.next,
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Let it flow...!",
                hintStyle: kBodyTextStyle.copyWith(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              style: kBodyTextStyle.copyWith(
                fontSize: 14,
              ),
              //controller: bodyController,
              onChanged: (String s) {
                body = s;
              },
              initialValue: body,
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

  void editNote(String title, String body, bool isPinned, int num) {
    final box = Boxes.getNotes();
    NoteModel updatedNote = NoteModel(
      title: title,
      body: body,
      isPinned: isPinned,
    );
    box.putAt(num, updatedNote);
  }
}
