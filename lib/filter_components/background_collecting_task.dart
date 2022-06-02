import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:passage_flutter/other_pages/awards_pages/water_data_storage/water_model.dart';
import 'package:provider/provider.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:developer';

class DataSample {
  double tdsSensor;
  double flowRate;
  int waterHeight1;
  int waterHeight2;
  DateTime timestamp;

  DataSample({
    required this.tdsSensor,
    required this.flowRate,
    required this.waterHeight1,
    required this.waterHeight2,
    required this.timestamp,
  });
}

class BackgroundCollectingTask extends Model {
  static BackgroundCollectingTask of(
    BuildContext context, {
    bool rebuildOnChange = false,
  }) =>
      ScopedModel.of<BackgroundCollectingTask>(
        context,
        rebuildOnChange: rebuildOnChange,
      );

  final BluetoothConnection? _connection;
  List<int> _buffer = List<int>.empty(growable: true);

  // @TODO , Such sample collection in real code should be delegated
  // (via `Stream<DataSample>` preferably) and then saved for later
  // displaying on chart (or even stright prepare for displaying).
  // @TODO ? should be shrinked at some point, endless colleting data would cause memory shortage.
  List<DataSample> samples = List<DataSample>.empty(growable: true);

  bool inProgress = false;

  BackgroundCollectingTask._fromConnection(this._connection, context) {
    log('starting');
    _connection?.input!.listen((data) {
      _buffer += data;
      log(data.toString());
      log('test');

      while (true) {
        log('checking for sample');
        // If there is a sample, and it is full sent
        int index = _buffer.indexOf('t'.codeUnitAt(0));
        if (index >= 0 && _buffer.length - index >= 7) {
          final DataSample sample = DataSample(
              tdsSensor: (_buffer[index + 1]).toDouble(),
              flowRate: (_buffer[index + 3] + _buffer[index + 4] / 100),
              waterHeight2: (_buffer[index + 5]),
              waterHeight1: (_buffer[index + 6]),
              timestamp: DateTime.now());
          _buffer.removeRange(0, index + 7);

          samples.add(sample);
          notifyListeners(); // Note: It shouldn't be invoked very often - in this example data comes at every second, but if there would be more data, it should update (including repaint of graphs) in some fixed interval instead of after every sample.
          Provider.of<WaterStore>(context, listen: false)
              .addWater(sample.flowRate * 1000);
        }
        // Otherwise break
        else {
          log('break');
          break;
        }
      }
    }).onDone(() {
      log('on Done');
      inProgress = false;
      notifyListeners();
    });
  }

  static Future<BackgroundCollectingTask> connect(
      BluetoothDevice server, BuildContext context) async {
    final BluetoothConnection connection =
        await BluetoothConnection.toAddress(server.address);
    return BackgroundCollectingTask._fromConnection(connection, context);
  }

  void dispose() {
    _connection?.dispose();
  }

  Future<void> start() async {
    inProgress = true;
    _buffer.clear();
    samples.clear();
    notifyListeners();
    _connection?.output.add(ascii.encode('start'));
    await _connection?.output.allSent;
  }

  Future<void> cancel() async {
    inProgress = false;
    notifyListeners();
    _connection?.output.add(ascii.encode('stop'));
    await _connection?.finish();
  }

  Future<void> pause() async {
    inProgress = false;
    notifyListeners();
    _connection?.output.add(ascii.encode('stop'));
    await _connection?.output.allSent;
  }

  Future<void> reasume() async {
    inProgress = true;
    notifyListeners();
    _connection?.output.add(ascii.encode('start'));
    await _connection?.output.allSent;
  }

  Iterable<DataSample> getLastOf(Duration duration) {
    DateTime startingTime = DateTime.now().subtract(duration);
    int i = samples.length;
    do {
      i -= 1;
      if (i <= 0) {
        break;
      }
    } while (samples[i].timestamp.isAfter(startingTime));
    return samples.getRange(i, samples.length);
  }
}
