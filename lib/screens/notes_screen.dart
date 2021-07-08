import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'add_note_screen.dart';
import 'package:basic_notes/widgets/side_drawer.dart';

class NotesScreen extends StatefulWidget {
  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
        // leading: IconButton(
        //   icon: const Icon(LineIcons.bars),
        //   onPressed: () {},
        // ),
        actions: [
          IconButton(
            icon: const Icon(LineIcons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(LineIcons.verticalEllipsis),
            onPressed: () {},
          ),
        ],
      ),
      drawer: SideDrawer(),
      body: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        children: List.generate(
          20,
          (index) => Container(
            color: const Color(0xff363333),
            child: Text(
              index.toString(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        height: 50,
        width: 100,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    AddNoteScreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return SlideTransition(
                    position: animation.drive(
                      Tween(
                        begin: const Offset(0, 1),
                        end: const Offset(0, 0),
                      ).chain(CurveTween(curve: Curves.easeOutCubic)),
                    ),
                    child: child,
                  );
                },
              ),
            );
          },
          backgroundColor: const Color(0xffE16428),
          child: const Icon(LineIcons.plus),
          mini: true,
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
    );
  }
}
