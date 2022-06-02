import 'package:path_provider/path_provider.dart';

import 'dart:async';
import 'dart:io';
import 'dart:developer';

//This class reads and writes from memory.
//https://docs.flutter.dev/cookbook/persistence/reading-writing-files

class WaterStorage {
  late int totalWater;

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/water.txt');
  }

  Future<double> readWater() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();
      log('Water file contents: $contents');

      return double.parse(contents);
    } catch (e) {
      log(e.toString());
      // Most likely error is that this is being run for the first time.
      //return the default value in this case

      return 0;
    }
  }

  Future<File> writeWater(double data) async {
    final file = await _localFile;

    log('Water: $data');
    return file.writeAsString('$data');
  }
}
