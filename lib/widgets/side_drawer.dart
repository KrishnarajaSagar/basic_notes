import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:basic_notes/constants.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({Key? key}) : super(key: key);

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
            buildDrawerListTile(title: "Notes", icon: LineIcons.stickyNote),
            buildDrawerListTile(title: "Saved", icon: LineIcons.bookmark),
            buildDrawerListTile(title: "Settings", icon: LineIcons.cog),
            buildDrawerListTile(
                title: "Exit", icon: LineIcons.alternateSignOut),
          ],
        ),
      ),
    );
  }
}

Widget buildDrawerListTile({required String title, required IconData icon}) {
  return ListTile(
    leading: Icon(
      icon,
      color: Colors.white,
    ),
    title: Text(
      title,
      style: kBodyTextStyle,
    ),
    onTap: () {},
  );
}
