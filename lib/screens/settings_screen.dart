import 'package:basic_notes/constants.dart';
import 'package:basic_notes/widgets/side_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:basic_notes/providers/theme_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    Size device = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(LineIcons.bars),
              onPressed: () => Scaffold.of(context).openDrawer(),
            );
          },
        ),
      ),
      drawer: SideDrawer(3),
      // body: Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   children: [
      //     const Flexible(
      //       child: Icon(LineIcons.adjust),
      //     ),
      //     Flexible(
      //       flex: 10,
      //       child: Text(
      //         "Dark Mode",
      //         style: Theme.of(context).textTheme.bodyText1,
      //       ),
      //     ),
      //     Flexible(
      //       child: Switch(
      //           activeColor: Theme.of(context).colorScheme.secondary,
      //           value: themeProvider.isDarkMode,
      //           onChanged: (value) {
      //             final provider =
      //                 Provider.of<ThemeProvider>(context, listen: false);
      //             provider.toggleTheme(value);
      //           }),
      //
      //     ),
      //   ],
      // ),
      body: ListView(
        children: [
          ListTile(
            tileColor: Theme.of(context).colorScheme.background,
            leading: Icon(
              LineIcons.adjust,
              color: Theme.of(context).iconTheme.color,
            ),
            title: Text(
              "Dark Mode",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            trailing: Switch(
              activeColor: Theme.of(context).colorScheme.secondary,
              value: themeProvider.isDarkMode,
              onChanged: (value) {
                final provider =
                    Provider.of<ThemeProvider>(context, listen: false);
                provider.toggleTheme(value);
              },
            ),
          ),
        ],
      ),
    );
  }
}
