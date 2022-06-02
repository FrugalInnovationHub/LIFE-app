import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:passage_flutter/theme/app_theme.dart';

//App Bar for secondary pages (has a back button)

AppBar secondaryAppBar(context, title) {
  return AppBar(
    leadingWidth: 260,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back),
      iconSize: 40,
      color: AppTheme.colors.darkBlue,
      onPressed: () {
        Navigator.pop(context);
      },
      tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
    ),
    centerTitle: true,
    backgroundColor: AppTheme.colors.lightBlue,
    title: Text(
      title,
      style: const TextStyle(color: Colors.black),
    ),
    toolbarHeight: 60,
    elevation: 0,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Color(0xffDDF5FF), // Status bar
    ),
  );
}
