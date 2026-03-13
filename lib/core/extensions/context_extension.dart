import 'package:flutter/material.dart';

extension ContextExtension on BuildContext{

  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;

  Future<Object?> pushNamed(String routeName, {Object? arguments}) => Navigator.of(this).pushNamed(routeName, arguments: arguments);
  Future<Object?> popAndPushNamed(String routeName, {Object? arguments}) => Navigator.of(this).popAndPushNamed(routeName, arguments: arguments);
  Future<Object?> pushReplacementNamed(String routeName, {Object? arguments}) => Navigator.of(this).pushReplacementNamed(routeName, arguments: arguments);
  void pop() => Navigator.of(this).pop();

  void unfocus([FocusManager? focusManager]) => (focusManager ?? FocusManager.instance).primaryFocus?.unfocus();

}