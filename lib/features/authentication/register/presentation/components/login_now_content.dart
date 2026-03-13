import 'package:chat/core/common_widgets/common_text.dart';
import 'package:chat/core/common_widgets/glass_container.dart';
import 'package:chat/core/constants/app_insets.dart';
import 'package:chat/core/constants/app_sizes.dart';
import 'package:chat/core/extensions/context_extension.dart';
import 'package:chat/core/router/app_routes.dart';
import 'package:flutter/material.dart';

class LoginNowContent extends StatelessWidget {

  const LoginNowContent({ 
    super.key
  });

  @override
  Widget build(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: AppSizes.size4,
      children: <Widget>[
        CommonText(
          text: "Already have an account?",
        ),
        GestureDetector(
          onTap: () => context.pushNamed(AppRoutes.login),
          child: GlassContainer(
            padding: AppInsets.a8,
            child: CommonText(
              text: "Sign in now!"
            )
          )
        )
      ]
    );
  }
}