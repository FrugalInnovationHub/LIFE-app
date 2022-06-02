import 'package:flutter/material.dart';
import 'package:passage_flutter/components/secondary_app_bar.dart';
import 'package:passage_flutter/other_pages/awards_pages/trophy_data_storage/trophy_progress_model.dart';
import 'package:passage_flutter/other_pages/awards_pages/water_data_storage/water_model.dart';
import 'package:provider/provider.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  _clearWaterProgress() {
    Provider.of<WaterStore>(context, listen: false).clearWater();
  }

  _clearTrophyProgress() {
    Provider.of<TrophyProgressStore>(context, listen: false).clearTrophies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: secondaryAppBar(context, 'Teacher Resources'),
        body: Center(
            child: Column(
          children: [
            TextButton(
              onPressed: () => {
                showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        _buildAlert(context, _clearWaterProgress, "Water"))
              },
              child: const Text("Clear Water data"),
            ),
            TextButton(
              onPressed: () => {
                showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        _buildAlert(context, _clearTrophyProgress, "Trophy"))
              },
              child: const Text("Clear Trophy data"),
            )
          ],
        )));
  }
}

Widget _buildAlert(
    BuildContext context, Function() _clearProgress, String _data) {
  return AlertDialog(
    title: const Text('Clear Data?'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Are you sure you want to clear the $_data data?"),
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
