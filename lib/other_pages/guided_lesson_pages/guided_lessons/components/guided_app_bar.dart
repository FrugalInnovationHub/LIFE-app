import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:passage_flutter/theme/app_theme.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

AppBar guidedAppBar(
    context,
    String title,
    Function scrollToCurrent,
    ItemScrollController controller,
    int progressVisual,
    void Function() clearProgress) {
  return AppBar(
    leadingWidth: 260,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back),
      iconSize: 40,
      color: AppTheme.colors.darkBlue,
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    bottom: PreferredSize(
        child: LinearProgressIndicator(
          value: progressVisual / 100,
        ),
        preferredSize: const Size(10, 10)),

    actions: <Widget>[
      Text('Progress: $progressVisual%',
          style: const TextStyle(color: Colors.black)),
      TextButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) =>
                _buildAlert(context, clearProgress, controller),
          );
        },
        child: const Text('Reset Progress'),
      ),
      TextButton(
        onPressed: () {
          scrollToCurrent();
        },
        child: const Text('Current Progress'),
      ),
      IconButton(
        icon: const Icon(MdiIcons.account),
        iconSize: 50,
        color: AppTheme.colors.darkBlue,
        onPressed: () {
          Navigator.pushNamed(context, '/profile');
        },
        tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
      ),
    ],
    centerTitle: true,
    // Here we take the value from the MyHomePage object that was created by
    // the App.build method, and use it to set our appbar title.
    backgroundColor: AppTheme.colors.lightBlue,
    title: Text(
      title,
      style: const TextStyle(color: Colors.black),
    ),
    toolbarHeight: 80,
    elevation: 0,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Color(0xffDDF5FF), // Status bar
    ),
  );
}

Widget _buildAlert(BuildContext context, Function() _clearProgress,
    ItemScrollController _controller) {
  return AlertDialog(
    title: const Text('Reset Progress?'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
            "Are you sure you want to reset your progress in this learning adventure?"),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () {
            _clearProgress();
            Navigator.of(context).pop();
          },
          child: const Text('Yes'),
        ),
      ],
    ),
    actions: <Widget>[
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('Close'),
      ),
    ],
  );
}
