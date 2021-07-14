import 'package:basic_notes/widgets/side_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:basic_notes/providers/theme_provider.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';

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
        title: Text(
          "Settings",
          style: Theme.of(context).textTheme.bodyText1,
        ),
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
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          content: Text("Press back again to exit"),
          behavior: SnackBarBehavior.floating,
        ),
        child: ListView(
          children: [
            ListTile(
              tileColor: Theme.of(context).scaffoldBackgroundColor,
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
      ),
    );
  }
}
