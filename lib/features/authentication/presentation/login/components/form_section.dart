import 'package:flutter/material.dart';

import 'package:chat/core/style/app_sizes.dart';
import '../../../../../core/style/app_insets.dart';
import '../../../../../core/common_widgets/glass_container.dart';
import 'field_content.dart';
import 'register_now_content.dart';

class FormSection extends StatelessWidget {

  const FormSection({super.key});

  @override
  Widget build(BuildContext context){
    return GlassContainer(
        padding: AppInsets.a16,
        child: Column(
        spacing: AppSizes.size8,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FieldContent(),
          RegisterNowContent()
        ]
      )
    );
  }
}