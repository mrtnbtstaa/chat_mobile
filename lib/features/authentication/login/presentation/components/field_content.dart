import 'package:flutter/material.dart';

import '../../../../../core/common_widgets/common_elevated_button.dart';
import '../../../../../core/common_widgets/common_text_field.dart';
import '../../../../../core/constants/app_insets.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/extensions/context_extension.dart';

class FieldContent extends StatelessWidget {

  const FieldContent({ 
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.onLoginTap
   });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onLoginTap;

  @override
  Widget build(BuildContext context){
    return Column(
      spacing: AppSizes.size16,
      children: <Widget>[
        CommonTextField(
          hintText: "Johndoe@gmail.com",
          text: "Email",
          onChanged: (val){},
          controller: emailController
        ),
        CommonTextField(
          hintText: "********",
          onChanged: (val){},
          text: "Password",
          controller: passwordController,
          isObsecure: true,
          hasSuffixIcon: true,
          iconSuffixData: Icons.remove_red_eye_sharp,
          onSuffixButtonPressed: (){}
        ),
        CommonElevatedButton(
          width: context.width,
          height: AppSizes.size64,
          elevatedPadding: AppInsets.h4,
          onButtonPressed: onLoginTap,
          text: "Sign in",
        )
      ]
    );
  }
}