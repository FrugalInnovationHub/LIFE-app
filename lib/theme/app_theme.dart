import 'package:flutter/material.dart';
import 'package:passage_flutter/theme/app_colors.dart';

@immutable
class AppTheme {
  static const colors = AppColors();

  const AppTheme._();

  static ThemeData define() {
    return ThemeData();
  }
}
