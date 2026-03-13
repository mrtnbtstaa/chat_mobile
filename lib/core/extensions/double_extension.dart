import 'package:flutter/material.dart';

extension DoubleExtension on double{

  SizedBox width() => SizedBox(width: this);
  SizedBox height() => SizedBox(height: this);

}