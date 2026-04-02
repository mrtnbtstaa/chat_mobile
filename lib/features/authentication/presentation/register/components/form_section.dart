import 'package:chat/core/extensions/double_extension.dart';
import 'package:flutter/material.dart';

import 'package:chat/core/style/app_sizes.dart';
import 'field_content.dart';


class FormSection extends StatelessWidget {

  const FormSection({ 
    super.key,
    // required this.imageProvider
  });

  // final ImageProvider imageProvider;

  @override
  Widget build(BuildContext context){
  return Column(
    spacing: AppSizes.size8,
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
        AppSizes.size24.height(),
        FieldContent(
          // imageProvider: imageProvider,
        ),
        AppSizes.size2.height(),
      ]
    );
  }
}