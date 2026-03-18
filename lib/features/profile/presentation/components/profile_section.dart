import 'package:chat/core/common_widgets/common_divider.dart';
import 'package:flutter/material.dart';

import '../../../../core/common_widgets/common_text.dart';
import '../../../../core/extensions/double_extension.dart';
import '../../../../core/common_widgets/common_avatar.dart';
import '../../../../core/common_widgets/common_container.dart';
import '../../../../core/common_widgets/common_icon.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_images.dart';
import '../../../../core/style/app_sizes.dart';
import 'package:icons_plus/icons_plus.dart';

class ProfileSection extends StatelessWidget {
const ProfileSection({ super.key });

  @override
  Widget build(BuildContext context){
    return Column(
      children: <Widget>[
        Material(
          color: Colors.transparent,
          elevation: 8.0,
          shape: CircleBorder(),
          shadowColor: Colors.black.withValues(alpha: 0.5),
          child: Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.bgColor02,
                    width: AppSizes.size2
                  )
                ),
                child: CommonAvatar(
                  path: AppImages.profile,
                  radius_: AppSizes.size72
                )
              ),
              Positioned(
                bottom: 10,
                right: 0,
                child: CommonContainer(
                  width: AppSizes.size32,
                  height: AppSizes.size32,
                  boxDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                    border: Border.all(
                      color: AppColors.bgColor02,
                      width: AppSizes.size2
                    )
                  ),
                  child: CommonIcon(
                    iconData: BoxIcons.bx_check,
                    iconColor: AppColors.bgColor02
                  )
                )
              )
            ]
          )
        ),
        AppSizes.spacing8.height(),
        CommonText(
          text: "John Doe",
          fontWeight: FontWeight.bold,
          fontSize: AppSizes.font24,
        ),
        CommonText(
          text: "19201.bautista.martin.s@gmail.com",
          fontSize: AppSizes.font16
        ),
        CommonDivider(
          indent_: AppSizes.size16,
          endIndent_: AppSizes.size16,
          thickness_: AppSizes.size2,
        )
      ]
    );
  }
}