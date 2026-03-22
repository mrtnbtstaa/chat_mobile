import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/common_widgets/common_text.dart';
import '../../../../../core/common_widgets/glass_container.dart';
import '../../../../../core/router/app_routes.dart';
import '../../../../../core/style/app_insets.dart';
import '../../../../../core/style/app_sizes.dart';

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
          onTap: () => context.go(AppRoutes.login),
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