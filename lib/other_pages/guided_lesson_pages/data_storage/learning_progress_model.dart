import 'package:flutter/material.dart';
import 'package:passage_flutter/other_pages/guided_lesson_pages/data_storage/easy_data.dart';

import 'learning_progress_storage.dart';
import 'dart:developer';

class LearningProgressStore extends ChangeNotifier {
  //The Data Structure:
  //      scienceOne:  [0, 0]
  //the integers are quiz values - 0 for not complete, 1 for complete
  // The array should be (number of quizzes) in length

  EasyData _progressData = EasyData(mathOne: [0, 0], scienceOne: [0, 0]);

  EasyData getProgressData() => _progressData;

  final LearningProgressStorage progressStorage = LearningProgressStorage();

  void clearProgress(String name) {
    //create a map & and iterable list of keys
    Map temp = _progressData.toMap();
    Iterable keysList = temp.keys;

    //find length, then create a List of 0's
    int length = temp[name].length;
    temp[name] = List.filled(length, 0);

    _progressData = EasyData(
        mathOne: temp[keysList.elementAt(0)],
        scienceOne: temp[keysList.elementAt(1)]);

    log('Progress Cleared');
    progressStorage.writeProgress(_progressData);
    notifyListeners();
  }

  void changeProgress(String name, int index, int value) {
    Map temp = _progressData.toMap();
    temp[name][index] = value;

    //create list of keys so that mapping can be done dynamically
    Iterable keysList = temp.keys;

    //dynamically map the Map named temp onto the progressData object because objects
    //in Flutter suck and aren't powerful unlike in JavaScript the true king.
    _progressData = EasyData(
        mathOne: temp[keysList.elementAt(0)],
        scienceOne: temp[keysList.elementAt(1)]);

    //store it in file
    progressStorage.writeProgress(_progressData);
    log('progress Changed');
    notifyListeners();
  }

  LearningProgressStore() {
    progressStorage.readProgress().then((EasyData value) {
      Map temp = value.toMap();
      Iterable keysList = temp.keys;
      //TODO: finish this - should check if the data that is saved is the right length.
      // If not it should add as many 0's as necessary, or subtract as many digits from the back.

      // for (var key in keysList){
      //   if (temp[key])
      // }
      _progressData = value;
      log('created with value: $_progressData');
      //notify listeners is needed here because this is a future so it takes a second to return
      //without it progressData is always going to start @ 0.
      notifyListeners();
    });
  }
}
