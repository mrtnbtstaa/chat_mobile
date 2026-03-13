import 'package:chat/core/router/app_routes.dart';
import 'package:flutter/material.dart';

import 'components/form_section.dart';
import '../../../../core/common_widgets/animated_background.dart';
import '../../../../core/common_widgets/common_container.dart';
import '../../../../core/common_widgets/common_scaffold.dart';
import '../../../../core/common_widgets/common_text.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/extensions/context_extension.dart';

class LoginPage extends StatelessWidget {
  
  const LoginPage({ super.key });

  @override
  Widget build(BuildContext context){
    return CommonScaffold(
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Stack(
          alignment: AlignmentGeometry.center,
          children: <Widget>[
            CommonContainer(
              width: context.width,
              height: context.height,
              child: SizedBox.expand(),
            ),
            Positioned.fill(child: AnimatedBackground()),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: AppSizes.size8,
              children: <Widget>[
                  CommonText(
                    text: "Welcome Back!",
                    fontWeight: FontWeight.bold,
                    fontSize: AppSizes.font32,
                  ),
                  FormSection(
                    onRegisterTap: () => context.pushNamed(AppRoutes.register),
                    onLoginTap: () => context.pushNamed(AppRoutes.home),
                    emailController: TextEditingController(),
                    passwordController: TextEditingController()
                  )
              ]
            )
          ]
        )
      )
    );
  }
}