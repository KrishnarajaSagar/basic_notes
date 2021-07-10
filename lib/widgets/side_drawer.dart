import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:basic_notes/constants.dart';
import 'package:basic_notes/screens/notes_screen.dart';
import 'package:basic_notes/screens/saved_notes_screen.dart';

class SideDrawer extends StatefulWidget {
  int drawerIndicator;
  SideDrawer(this.drawerIndicator);

  @override
  State<SideDrawer> createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: const Color(0xff363333),
        child: ListView(
          children: [
            DrawerHeader(
              child: Center(
                child: Text(
                  "Basic Notes",
                  style: kBodyTextStyle.copyWith(fontSize: 24),
                ),
              ),
            ),
            buildDrawerListTile(
                title: "Notes",
                icon: LineIcons.stickyNote,
                selected: widget.drawerIndicator == 1 ? true : false,
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          NotesScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                    ),
                  );
                }),
            buildDrawerListTile(
              title: "Saved",
              icon: LineIcons.bookmark,
              selected: widget.drawerIndicator == 2 ? true : false,
              onTap: () {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        SavedNotesScreen(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                  ),
                );
              },
            ),
            buildDrawerListTile(
              title: "Settings",
              icon: LineIcons.cog,
              selected: widget.drawerIndicator == 3 ? true : false,
            ),
            buildDrawerListTile(
                title: "Exit", icon: LineIcons.alternateSignOut),
          ],
        ),
      ),
    );
  }
}

Widget buildDrawerListTile(
    {required String title,
    required IconData icon,
    bool selected = false,
    onTap}) {
  return ListTile(
    leading: Icon(
      icon,
      color: Colors.white,
    ),
    title: Text(
      title,
      style: kBodyTextStyle,
    ),
    onTap: onTap,
    selected: selected,
    selectedTileColor: kAccentColor.withOpacity(0.5),
  );
}
