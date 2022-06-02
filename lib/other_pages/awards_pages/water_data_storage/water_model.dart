import 'package:flutter/material.dart';

import 'water_storage.dart';
import 'dart:developer';

class WaterStore extends ChangeNotifier {
  double _totalWater = 0;

  double getWaterData() => _totalWater;

  final WaterStorage progressStorage = WaterStorage();

  void clearWater() {
    _totalWater = 0;
    progressStorage.writeWater(_totalWater);
    notifyListeners();
  }

  void addWater(double amount) {
    _totalWater += amount;
    progressStorage.writeWater(_totalWater);
    notifyListeners();
  }

  WaterStore() {
    progressStorage.readWater().then((double value) {
      _totalWater = value;
      log('Total water initialized as: $_totalWater');
      notifyListeners();
    });
  }
}
