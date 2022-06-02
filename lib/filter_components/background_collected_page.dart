import 'package:flutter/material.dart';
import 'package:passage_flutter/theme/app_colors.dart';

import 'background_collecting_task.dart';
import './helpers/LineChart.dart';
import './helpers/PaintStyle.dart';

class BackgroundCollectedPage extends StatefulWidget {
  const BackgroundCollectedPage({Key? key}) : super(key: key);

  @override
  State<BackgroundCollectedPage> createState() =>
      _BackgroundCollectedPageState();
}

class _BackgroundCollectedPageState extends State<BackgroundCollectedPage> {
  //how much of the data is shown

  @override
  Widget build(BuildContext context) {
    final BackgroundCollectingTask? task =
        BackgroundCollectingTask.of(context, rebuildOnChange: true);

    // Arguments shift is needed for timestamps as miliseconds in double could loose precision.
    final int? argumentsShift =
        task?.samples.first.timestamp.millisecondsSinceEpoch;

    const Duration showDuration =
        Duration(hours: 1); // @TODO . show duration should be configurable
    final Iterable<DataSample>? lastSamples = task?.getLastOf(showDuration);

    final Iterable<double>? arguments = lastSamples?.map((sample) {
      return (sample.timestamp.millisecondsSinceEpoch - argumentsShift!)
          .toDouble();
    });

    // Step for argument labels
    const Duration argumentsStep =
        Duration(minutes: 5); // @TODO . step duration should be configurable

    // Find first timestamp floored to step before
    final DateTime beginningArguments = lastSamples!.first.timestamp;
    DateTime beginningArgumentsStep = DateTime(beginningArguments.year,
        beginningArguments.month, beginningArguments.day);
    while (beginningArgumentsStep.isBefore(beginningArguments)) {
      beginningArgumentsStep = beginningArgumentsStep.add(argumentsStep);
    }
    beginningArgumentsStep = beginningArgumentsStep.subtract(argumentsStep);
    final DateTime endingArguments = lastSamples.last.timestamp;

    // Generate list of timestamps of labels
    final Iterable<DateTime> argumentsLabelsTimestamps = () sync* {
      DateTime timestamp = beginningArgumentsStep;
      yield timestamp;
      while (timestamp.isBefore(endingArguments)) {
        timestamp = timestamp.add(argumentsStep);
        yield timestamp;
      }
    }();

    // Map strings for labels
    final Iterable<LabelEntry> argumentsLabels =
        argumentsLabelsTimestamps.map((timestamp) {
      return LabelEntry(
          (timestamp.millisecondsSinceEpoch - argumentsShift!).toDouble(),
          ((timestamp.hour <= 9 ? '0' : '') +
              timestamp.hour.toString() +
              ':' +
              (timestamp.minute <= 9 ? '0' : '') +
              timestamp.minute.toString()));
    });

    return Scaffold(
        appBar: AppBar(
          title: const Text('Collected data'),
          actions: <Widget>[
            // Progress circle
            (task != null && task.inProgress
                ? FittedBox(
                    child: Container(
                        margin: const EdgeInsets.all(16.0),
                        child: const CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white))))
                : Container(/* Dummy */)),
            // Start/stop buttons
            (task != null && task.inProgress
                ? IconButton(
                    icon: const Icon(Icons.pause), onPressed: task.pause)
                : IconButton(
                    icon: const Icon(Icons.play_arrow),
                    onPressed: task?.reasume)),
          ],
        ),
        body: ListView(
          children: <Widget>[
            const Divider(),
            const ListTile(
                leading: Icon(Icons.water_drop),
                title: Text('TDS Sensor (Water Purity) '),
                subtitle: Text("Unit: Parts per million")),
            LineChart(
              constraints: const BoxConstraints.expand(height: 350),
              arguments: arguments!,
              argumentsLabels: argumentsLabels,
              values: [
                lastSamples.map((sample) => sample.tdsSensor),
              ],
              verticalLinesStyle: const PaintStyle(color: Colors.grey),
              additionalMinimalHorizontalLabelsInterval: 0,
              additionalMinimalVerticalLablesInterval: 0,
              seriesPointsStyles: const [
                null,
                //const PaintStyle(style: PaintingStyle.stroke, strokeWidth: 1.7*3, color: Colors.indigo, strokeCap: StrokeCap.round),
              ],
              seriesLinesStyles: [
                PaintStyle(
                    style: PaintingStyle.stroke,
                    strokeWidth: 1.7,
                    color: const AppColors().buttonBlue),
              ],
            ),
            const Divider(),
            ListTile(
              leading: Icon(
                Icons.water,
                color: const AppColors().buttonBlue,
              ),
              title: const Text('Flowrate Sensor (Measures speed of pump)'),
              subtitle: const Text("Unit: Liters per Minute"),
            ),
            LineChart(
              constraints: const BoxConstraints.expand(height: 350),
              arguments: arguments,
              argumentsLabels: argumentsLabels,
              values: [
                lastSamples.map((sample) => sample.flowRate),
              ],
              verticalLinesStyle: const PaintStyle(color: Colors.grey),
              additionalMinimalHorizontalLabelsInterval: 0,
              additionalMinimalVerticalLablesInterval: 0,
              seriesPointsStyles: const [
                null,
                //const PaintStyle(style: PaintingStyle.stroke, strokeWidth: 1.7*3, color: Colors.indigo, strokeCap: StrokeCap.round),
              ],
              seriesLinesStyles: [
                PaintStyle(
                    style: PaintingStyle.stroke,
                    strokeWidth: 1.7,
                    color: const AppColors().buttonBlue),
              ],
            ),
            const Divider(),
            ListTile(
              leading: Icon(
                Icons.call_to_action,
                color: const AppColors().buttonBlue,
              ),
              title: const Text('Reservoir 1'),
            ),
            Text(
                lastSamples.last.waterHeight1.toInt() == 1
                    ? "Full"
                    : "Not Full",
                style: TextStyle(
                    color: lastSamples.last.waterHeight1 == 1
                        ? Colors.green
                        : Colors.red)),
            const Divider(),
            ListTile(
              leading: Icon(
                Icons.call_to_action,
                color: const AppColors().buttonBlue,
              ),
              title: const Text('Reservoir 2'),
            ),
            Text(
                lastSamples.last.waterHeight2.toInt() == 1
                    ? "Full"
                    : "Not Full",
                style: TextStyle(
                    color: lastSamples.last.waterHeight2 == 1
                        ? Colors.green
                        : Colors.red))
          ],
        ));
  }
}
