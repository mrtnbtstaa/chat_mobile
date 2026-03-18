import 'package:flutter/material.dart';

import 'package:chat/core/style/app_sizes.dart';
import '../../../../../core/style/app_insets.dart';
import '../../../../../core/common_widgets/glass_container.dart';
import 'field_content.dart';
import 'login_now_content.dart';

class FormSection extends StatelessWidget {

  const FormSection({ 
    super.key,
    required this.imageProvider
  });

  final ImageProvider imageProvider;

  @override
  Widget build(BuildContext context){
    return GlassContainer(
        padding: AppInsets.a16,
        child: Column(
        spacing: AppSizes.size8,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FieldContent(
            imageProvider: imageProvider,
          ),
          LoginNowContent()
        ]
      )
    );
  }
}