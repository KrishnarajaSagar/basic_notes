import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
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
        title: Text(
          "Add",
          style: Theme.of(context).textTheme.bodyText1,
        ),
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
          physics: const BouncingScrollPhysics(),
          children: [
            SizedBox(
              height: device.height / 7,
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Title",
                  hintStyle: Theme.of(context).textTheme.headline6!.copyWith(
                        fontSize: 28,
                        color: Colors.grey,
                      ),
                ),
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      fontSize: 28,
                    ),
                onChanged: (String s) {
                  title = s;
                },
                maxLines: 3,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                textInputAction: TextInputAction.next,
              ),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "Start typing content here...",
                hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                border: InputBorder.none,
              ),
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 14,
                  ),
              onChanged: (String s) {
                body = s;
              },
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
