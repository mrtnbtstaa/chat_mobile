import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/common_widgets/common_avatar.dart';
import '../../../../../core/common_widgets/common_container.dart';
import '../../../../../core/common_widgets/common_icon_button.dart';
import '../../../../../core/common_widgets/common_text.dart';
import '../../../../../core/style/app_images.dart';
import '../../../../../core/style/app_insets.dart';
import '../../../../../core/style/app_sizes.dart';

class AppbarSettingsSection extends StatelessWidget {
const AppbarSettingsSection({ super.key });

  @override
  Widget build(BuildContext context){
    return CommonContainer(
      backgroundColor: Colors.transparent,
      padding: AppInsets.h24,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: AppInsets.a8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CommonIconButton(
                    onButtonPressed: () => context.pop()
                  ),
                  CommonText(
                    text: "Appearance",
                    fontWeight: FontWeight.bold,
                    fontSize: AppSizes.font16,
                  )
                ]
              ),
              CommonAvatar(path: AppImages.profile)
            ]
          )
        )
      )
    );
  }
}