import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:basic_notes/constants.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({Key? key}) : super(key: key);

  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  @override
  Widget build(BuildContext context) {
    Size device = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit"),
        actions: [
          IconButton(
            icon: const Icon(LineIcons.save),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            height: device.height / 7,
            child: TextField(
              decoration: InputDecoration(
                hintText: "Title",
                hintStyle: kHintTextStyle.copyWith(
                  fontSize: 28,
                ),
                border: InputBorder.none,
              ),
              style: kTextStyle.copyWith(
                fontSize: 28,
              ),
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
              hintStyle: kHintTextStyle.copyWith(
                fontSize: 14,
              ),
              border: InputBorder.none,
            ),
            style: kTextStyle.copyWith(
              fontSize: 14,
            ),
            cursorColor: Colors.white,
            textCapitalization: TextCapitalization.sentences,
            keyboardType: TextInputType.multiline,
            //textInputAction: TextInputAction.newline,
            maxLines: null,
          ),
        ],
      ),
    );
  }
}
