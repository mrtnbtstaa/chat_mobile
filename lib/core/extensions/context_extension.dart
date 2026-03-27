import 'package:flutter/material.dart';

extension ContextExtension on BuildContext{

  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;

  void unfocus([FocusManager? focusManager]) => (focusManager ?? FocusManager.instance).primaryFocus?.unfocus();

}