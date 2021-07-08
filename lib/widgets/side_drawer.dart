import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const DrawerHeader(
          child: Center(
            child: Text("Basic Notes"),
          ),
        ),
        ListTile(
          leading: const Icon(LineIcons.bookmark),
          title: const Text("Saved"),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(LineIcons.cog),
          title: const Text("Saved"),
          onTap: () {},
        ),
        const Divider(),
        ListTile(
          leading: const Icon(LineIcons.alternateSignOut),
          title: const Text("Saved"),
          onTap: () {},
        ),
      ],
    );
  }
}
