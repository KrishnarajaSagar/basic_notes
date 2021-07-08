import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class ViewNoteScreen extends StatefulWidget {
  @override
  State<ViewNoteScreen> createState() => _ViewNoteScreenState();
}

class _ViewNoteScreenState extends State<ViewNoteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("View"),
        actions: [
          IconButton(
            icon: const Icon(LineIcons.edit),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(LineIcons.verticalEllipsis),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
