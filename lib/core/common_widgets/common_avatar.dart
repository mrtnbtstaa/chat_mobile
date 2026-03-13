import 'package:flutter/material.dart';

class CommonAvatar extends CircleAvatar{

  CommonAvatar({
    super.key,
    required this.path,
    this.radius_
  }) : super(
    backgroundImage: AssetImage(path),
    radius: radius_,
  );

  final String path;
  final double? radius_;
  
}