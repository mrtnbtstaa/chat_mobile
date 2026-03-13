import 'package:chat/core/common_widgets/common_text.dart';
import 'package:chat/core/common_widgets/glass_container.dart';
import 'package:chat/core/constants/app_insets.dart';
import 'package:chat/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class RegisterNowContent extends StatelessWidget {

  const RegisterNowContent({ 
    super.key,
    required this.onRegisterTap
  });

  final VoidCallback onRegisterTap;

  @override
  Widget build(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: AppSizes.size4,
      children: <Widget>[
        Flexible(
          child: CommonText(
            text: "Don't have an account?",
          ),
        ),
        GestureDetector(
          onTap: onRegisterTap,
          child: GlassContainer(
            padding: AppInsets.a8,
            child: CommonText(
              text: "Sign up now!"
            )
          )
        )
      ]
    );
  }
}