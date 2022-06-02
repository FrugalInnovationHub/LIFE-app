import 'package:flutter/material.dart';
import 'data_class.dart';

import 'trophy_progress_storage.dart';
import 'dart:developer';

class TrophyProgressStore extends ChangeNotifier {
  //set it to default - will be filled in as soon as its created
  DataClass _trophyData = DataClass(
      trophies: List.filled(50, 0),
      mostRecent: 100,
      initials: List.filled(50, 'AA'));

  DataClass getTrophyData() => _trophyData;

  final TrophyProgressStorage progressStorage = TrophyProgressStorage();

  void clearTrophies() {
    //set mostRecent to 100 since no trophies have been found
    _trophyData = DataClass(
        trophies: List.filled(50, 0),
        mostRecent: 100,
        initials: List.filled(50, 'AA'));
    log('trophies cleared');
    progressStorage.writeTrophies(_trophyData);
    notifyListeners();
  }

  void addTrophy(int index) {
    _trophyData.trophies[index] = 1;
    progressStorage.writeTrophies(_trophyData);
    notifyListeners();
  }

  void subtractTrophy(int index) {
    _trophyData.trophies[index] = 0;
    progressStorage.writeTrophies(_trophyData);
    notifyListeners();
  }

  void changeMostRecent(int index) {
    _trophyData.mostRecent = index;
    progressStorage.writeTrophies(_trophyData);
    notifyListeners();
  }

  void changeInitials(int index, String initials) {
    log('initials changed to: $initials');
    _trophyData.initials[index] = initials.toUpperCase();
    progressStorage.writeTrophies(_trophyData);
    notifyListeners();
  }

  //when the store is created, initialize it to whatever data is in storage.
  TrophyProgressStore() {
    progressStorage.readTrophies().then((DataClass value) {
      _trophyData = value;
      log('trophies list initialized as: $_trophyData');
      notifyListeners();
    });
  }
}
