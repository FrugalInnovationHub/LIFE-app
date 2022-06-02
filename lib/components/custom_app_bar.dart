import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:passage_flutter/other_pages/awards_pages/water_data_storage/water_model.dart';
import 'package:passage_flutter/theme/app_theme.dart';
import 'package:provider/provider.dart';

AppBar customAppBar(context, String title) {
  return AppBar(
    leadingWidth: 200, //obsolete now..
    leading: Padding(
      padding: const EdgeInsets.all(10),
      child: TextButton(
          child: Row(children: [
            const Icon(Icons.water_drop),
            Consumer<WaterStore>(
              builder: ((context, store, child) => Text(
                  '${store.getWaterData()}',
                  style: const TextStyle(color: Colors.black))),
            )
          ]),
          onPressed: () {
            Navigator.of(context).pushNamed('/lifetimeWater');
          },
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.0),
                      side: BorderSide(
                          color: AppTheme.colors.darkBlue, width: 4))))),
    ),

    actions: <Widget>[
      IconButton(
        icon: const Icon(MdiIcons.account),
        iconSize: 50,
        color: AppTheme.colors.darkBlue,
        onPressed: () {
          Navigator.pushNamed(context, '/settingsPage');
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
    toolbarHeight: 60,
    elevation: 0,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Color(0xffDDF5FF), // Status bar
    ),
  );
}
