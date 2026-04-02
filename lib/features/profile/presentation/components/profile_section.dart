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
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.lSurfaceLow,
                width: AppSizes.size4
              )
            ),
            child: CommonAvatar(
              path: AppImages.profile,
              radius_: AppSizes.size72
            )
          )
        ),
        AppSizes.spacing8.height(),
        CommonText(
          text: "John Doe",
          fontWeight: FontWeight.w800,
          fontSize: AppSizes.font24,
        ),
        AppSizes.size32.height(),
      ]
    );
  }
}