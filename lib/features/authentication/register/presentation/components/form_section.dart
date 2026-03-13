import 'package:flutter/material.dart';

import 'package:chat/core/constants/app_sizes.dart';
import '../../../../../core/constants/app_insets.dart';
import '../../../../../core/common_widgets/glass_container.dart';
import 'field_content.dart';
import 'login_now_content.dart';

class FormSection extends StatelessWidget {

  const FormSection({ 
    super.key,
    required this.onRegisterTap,
    required this.onLoginTap,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController
  });

  final VoidCallback onRegisterTap;
  final VoidCallback onLoginTap;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

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
              emailController: emailController,
              passwordController: passwordController,
              confirmPasswordController: confirmPasswordController,
              onLoginTap: onLoginTap,
            ),
            LoginNowContent(onRegisterTap: onRegisterTap)
          ]
        )
      )
    );
  }
}