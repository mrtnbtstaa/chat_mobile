import 'package:chat/core/common_widgets/common_divider.dart';
import 'package:chat/core/style/app_colors.dart';
import 'package:chat/core/style/app_sizes.dart';
import 'package:chat/features/profile/presentation/components/user_profile_status.dart';
import 'package:flutter/material.dart';

class UserStatusSection extends StatelessWidget {
const UserStatusSection({ super.key });

  @override
  Widget build(BuildContext context){
    return Column(
      spacing: AppSizes.size8,
      children: <Widget>[
        UserProfileStatus(),
        UserProfileStatus(
          color: AppColors.lSurfaceLow,
          descriptionColor: AppColors.lSurfaceLow,
          title: "About:",
          description: "Love to travel and explore new places.",
          fontWeight: FontWeight.w400,
        ),
        CommonDivider(
          indent_: AppSizes.size16,
          endIndent_: AppSizes.size16,
          thickness_: AppSizes.size2,
        )
      ],
    );
  }
}