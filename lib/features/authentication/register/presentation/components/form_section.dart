import 'package:flutter/material.dart';

import 'package:chat/core/constants/app_sizes.dart';
import '../../../../../core/constants/app_insets.dart';
import '../../../../../core/common_widgets/glass_container.dart';
import 'field_content.dart';
import 'login_now_content.dart';

class FormSection extends StatelessWidget {

  const FormSection({ 
    super.key,
    required this.passwordObsecure,
    required this.confirmPasswordObsecure,
    required this.imageProvider
  });

  final bool passwordObsecure;
  final bool confirmPasswordObsecure;
  final ImageProvider imageProvider;

  @override
  Widget build(BuildContext context){
    return Form(
      child: GlassContainer(
          padding: AppInsets.a16,
          child: Column(
          spacing: AppSizes.size8,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FieldContent(
              passwordObsecure: passwordObsecure,
              confirmPasswordObsecure: confirmPasswordObsecure,
              imageProvider: imageProvider,
            ),
            LoginNowContent()
          ]
        )
      )
    );
  }
}