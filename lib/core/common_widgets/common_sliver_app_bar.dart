import 'package:chat/core/common_widgets/common_avatar.dart';
import 'package:chat/core/common_widgets/common_icon_button.dart';
import 'package:chat/core/common_widgets/common_text.dart';
import 'package:chat/core/router/app_routes.dart';
import 'package:chat/core/style/app_colors.dart';
import 'package:chat/core/style/app_images.dart';
import 'package:chat/core/style/app_insets.dart';
import 'package:chat/core/style/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';

class CommonSliverAppBar extends StatelessWidget {

  final String text;

  const CommonSliverAppBar({ super.key, required this.text });

  @override
  Widget build(BuildContext context){
    return SliverAppBar(
      pinned: true,
      floating: true,
      backgroundColor: Colors.transparent,
      scrolledUnderElevation: 0.0,
      elevation: 0.0,
      title: Padding(
        padding: AppInsets.hv8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              spacing: AppSizes.spacing8,
              children: [
                CommonAvatar(
                  path: AppImages.profile,
                  radius_: AppSizes.size16,
                ),
                CommonText(
                  text: text,
                  fontWeight: FontWeight.w700,
                )
              ]
            ),
            Material(
              color: AppColors.primaryBrandColor,
              borderRadius: BorderRadius.circular(AppSizes.size8),
              child: CommonIconButton(
                onButtonPressed: () => context.pushNamed(AppRoutes.chatGroup),
                iconData: FontAwesome.user_plus_solid,
                iconSize: AppSizes.size24 - 4,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                iconColor: AppColors.lSurfaceLow,
              ),
            )
          ],
        ),
      ),
    );
  }
}

