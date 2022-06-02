import 'package:flutter/material.dart';
import 'package:passage_flutter/components/secondary_app_bar.dart';
import 'package:passage_flutter/other_pages/awards_pages/water_data_storage/water_model.dart';
import 'package:provider/provider.dart';
import 'package:timeline_tile/timeline_tile.dart';

/*
Each acheivement is one point on the timeline.
The achievement width is how long the line goes AFTER that point. So 
achievement width of index 0 is how long the timeline is from index 0
to index 1.
achievementWidths should be a little shorter.

Once we reach the index where total water is between two things, split it up and use the
hasIndicator flag.
the flag hasIndicator is used to make it cool.
*/
final List<String> achievements = [
  "100 drops..",
  "300 drops..",
  "600 drops..",
  "1,000 drops :)"
];
final List<int> achievementWidths = [100, 200, 300];

class LifetimeWater extends StatefulWidget {
  const LifetimeWater({Key? key}) : super(key: key);

  @override
  State<LifetimeWater> createState() => LifetimeWaterState();
}

class LifetimeWaterState extends State<LifetimeWater> {
  //will be changed as soon as it loads
  double _totalWater = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      _totalWater = Provider.of<WaterStore>(context).getWaterData();
    });
  }

  List<Widget> _createTimeline(List<String> achievements, double _totalWater,
      List<int> achievementWidths) {
    List<Widget> _list = [];
    int sum = achievementWidths.fold(0, (p, e) => p + e);
    //first tile
    _list.add(TimelineTile(
      axis: TimelineAxis.horizontal,
      alignment: TimelineAlign.end,
      isFirst: true,
      startChild: Container(
        constraints: const BoxConstraints(
          minHeight: 120,
        ),
        child: const Text("0 drops..."),
        color: Colors.blue,
      ),
    ));

    //TODO: make it split into water and not water
    int runningSum = achievementWidths[0];

    //middle tiles
    for (int i = 1; i < achievements.length - 1; i++) {
      _list.add(TimelineTile(
        axis: TimelineAxis.horizontal,
        alignment: TimelineAlign.end,
        startChild: Container(
          constraints: BoxConstraints(
            minHeight: 120,
            minWidth: achievementWidths[i].toDouble(),
          ),
          child: Text(achievements[i]),
          color: Colors.green,
        ),
      ));
    }
    //last tile
    _list.add(TimelineTile(
      axis: TimelineAxis.horizontal,
      alignment: TimelineAlign.end,
      isLast: true,
      startChild: Container(
        constraints: const BoxConstraints(
          minHeight: 120,
          minWidth: 25,
        ),
        color: _totalWater >= sum ? Colors.blue : Colors.grey,
      ),
    ));
    return _list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: secondaryAppBar(context, 'Lifetime Water'),
      body: Center(
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(children: [
                Text("Total Water: $_totalWater"),

                const SizedBox(height: 20),
                Expanded(
                  child: ListView(
                    children: _createTimeline(
                        achievements, _totalWater, achievementWidths),
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                const SizedBox(height: 20),
                //buttons below used for testing
                TextButton(
                    onPressed: () {
                      Provider.of<WaterStore>(context, listen: false)
                          .addWater(50);
                    },
                    child: const Text("Add 50 Water")),
                TextButton(
                    onPressed: () {
                      Provider.of<WaterStore>(context, listen: false)
                          .clearWater();
                    },
                    child: const Text("Clear Water")),
              ]))),
    );
  }
}
