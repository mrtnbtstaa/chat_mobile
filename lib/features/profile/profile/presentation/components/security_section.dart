
import 'package:chat/core/common_widgets/common_container.dart';
import 'package:chat/core/router/app_routes.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/common_widgets/common_icon.dart';
import '../../../../../core/common_widgets/common_text.dart';
import '../../../../../core/extensions/double_extension.dart';
import '../../../../../core/style/app_colors.dart';
import '../../../../../core/style/app_insets.dart';
import '../../../../../core/style/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class SecuritySection extends StatelessWidget {
const SecuritySection({ super.key });

  @override
  Widget build(BuildContext context){
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: AppInsets.h32,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CommonContainer(
              borderRadius: AppSizes.size8,
              padding: AppInsets.a8,
              child: CommonIcon(
                iconData: IonIcons.lock_closed,
                iconColor: AppColors.primaryBrandColor
              )
            ),
            AppSizes.size8.height(),
            CommonText(
              text: "Security",
              fontSize: AppSizes.font24,
              fontWeight: FontWeight.bold
            ),
            CommonText(
              text: "Manage Passwords",
              fontSize: AppSizes.font16
            ),
            AppSizes.size16.height(),
            GestureDetector(
              onTap: () => context.pushNamed(AppRoutes.changePassword),
              child: Row(
                spacing: AppSizes.spacing8,
                children: <Widget>[
                  CommonText(
                    text: "Change Password",
                    fontColor: AppColors.primaryBrandColor,
                    fontWeight: FontWeight.w700
                  ),
                  CommonIcon(
                    iconData: HeroIcons.arrow_right,
                    iconColor: AppColors.primaryBrandColor,
                    iconSize: AppSizes.size16
                  )
                ]
              )
            ),
            AppSizes.size32.height()
          ]
        )
      )
    );
  }
}