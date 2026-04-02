import 'package:chat/core/common_widgets/common_text.dart';
import 'package:chat/core/router/app_routes.dart';
import 'package:chat/core/style/app_colors.dart';
import 'package:chat/core/style/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
            text: "New to Ethereal?",
          ),
        ),
        GestureDetector(
          onTap: () => context.goNamed(AppRoutes.register),
          child: CommonText(
            text: "Sign up now!",
            fontColor: AppColors.primaryBrandColor,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.0,
          )
        )
      ]
    );
  }
}