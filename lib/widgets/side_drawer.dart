import 'package:basic_notes/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
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
        color: Theme.of(context).colorScheme.background,
        child: ListView(
          children: [
            DrawerHeader(
              child: Center(
                child: Text(
                  "Basic Notes",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 24,
                      ),
                ),
              ),
            ),
            buildDrawerListTile(
                context: context,
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
              context: context,
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
              context: context,
              title: "Settings",
              icon: LineIcons.cog,
              selected: widget.drawerIndicator == 3 ? true : false,
              onTap: () {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        SettingsScreen(),
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
          ],
        ),
      ),
    );
  }
}

Widget buildDrawerListTile(
    {required BuildContext context,
    required String title,
    required IconData icon,
    bool selected = false,
    onTap}) {
  return ListTile(
    leading: Icon(
      icon,
      color: Theme.of(context).iconTheme.color,
    ),
    title: Text(
      title,
      style: Theme.of(context).textTheme.bodyText1,
    ),
    onTap: onTap,
    selected: selected,
    selectedTileColor: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
  );
}
