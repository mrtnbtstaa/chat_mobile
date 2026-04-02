import 'package:chat/core/enum/app_theme.dart';
import 'package:chat/core/utils/settings_manager.dart';
import 'package:flutter/material.dart';

extension ContextExtension on BuildContext{

  bool get isDarkMode => SettingsManager().getTheme == AppTheme.dark;

  ThemeData get currentTheme => Theme.of(this);
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;

  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;

  void unfocus([FocusManager? focusManager]) => (focusManager ?? FocusManager.instance).primaryFocus?.unfocus();

}