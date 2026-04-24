import 'dart:io';

import 'package:flutter/material.dart';

class CommonAvatar extends StatelessWidget {

  final String path;
  final double? radius_;

  const CommonAvatar({ 
    super.key,
    required this.path,
    this.radius_
  });

  @override
  Widget build(BuildContext context){

  final bool isLocalFile = path.startsWith('/') || path.startsWith('file://');

    return CircleAvatar(
      radius: radius_,
      backgroundImage: isLocalFile ? FileImage(File(path)) as ImageProvider : AssetImage(path)
    );
  }
}