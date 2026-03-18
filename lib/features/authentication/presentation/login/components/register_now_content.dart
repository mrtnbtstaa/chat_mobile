import 'package:chat/core/common_widgets/common_text.dart';
import 'package:chat/core/common_widgets/glass_container.dart';
import 'package:chat/core/extensions/context_extension.dart';
import 'package:chat/core/router/app_routes.dart';
import 'package:chat/core/style/app_insets.dart';
import 'package:chat/core/style/app_sizes.dart';
import 'package:flutter/material.dart';

class RegisterNowContent extends StatelessWidget {

  const RegisterNowContent({super.key});

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
          onTap: () => context.pushNamed(AppRoutes.register),
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