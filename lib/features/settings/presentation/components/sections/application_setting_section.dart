import 'package:chat/core/extensions/double_extension.dart';
import 'package:chat/core/router/app_routes.dart';
import 'package:chat/core/style/app_insets.dart';
import 'package:chat/core/style/app_sizes.dart';
import 'package:chat/features/settings/presentation/components/application_content.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../../../core/common_widgets/common_text.dart';
import '../../../../../core/style/app_colors.dart';
import 'package:flutter/material.dart';

class ApplicationSettingSection extends StatelessWidget {
const ApplicationSettingSection({ super.key });

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: AppInsets.h16,
      child: Column(
        spacing: AppSizes.size8,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AppSizes.size24.height(),
          CommonText(
            text: "Application",
            fontColor: AppColors.primaryBrandColor,
            letterSpacing: AppSizes.size4 - 1,
            fontWeight: FontWeight.w500,
          ),
          ApplicationContent(
            onTap: () => context.pushNamed(AppRoutes.appearance),
          ),
          ApplicationContent(
            title: "Privacy & Security",
            description: "End-to-end encryption, blocked users",
            iconData: HeroIcons.shield_check,
            iconColor: AppColors.error,
            onTap: (){print("Hello wolrd");},
          )
        ],
      ),
    );
  }
}