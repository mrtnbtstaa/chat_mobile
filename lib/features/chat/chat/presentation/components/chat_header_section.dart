import 'package:chat/core/common_widgets/common_avatar.dart';
import 'package:chat/core/extensions/context_extension.dart';
import 'package:chat/core/router/app_routes.dart';

import '../../../../../core/common_widgets/common_text_field.dart';
import '../../../../../core/style/app_images.dart';
import '../../../../../core/extensions/double_extension.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import '../../../../../core/common_widgets/common_icon.dart';
import '../../../../../core/common_widgets/glass_container.dart';
import '../../../../../core/style/app_sizes.dart';

class ChatHeaderSection extends StatelessWidget {

  const ChatHeaderSection({ 
    super.key,
    required this.onSearchTap,
    required this.onGroupTap,
  });

  final VoidCallback onSearchTap;
  final VoidCallback onGroupTap;


  @override
  Widget build(BuildContext context){
    return GlassContainer(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      borderRadiusGeometry: BorderRadius.circular(0.0),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: AppSizes.size8, horizontal: AppSizes.size8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              onTap: () => context.pushNamed(AppRoutes.profile),
              child: CommonAvatar(path: AppImages.profile),
            ),
            Flexible(
              child: CommonTextField(
                height: AppSizes.size48,
                padding: EdgeInsets.only(left: AppSizes.size8),
                contentPadding: EdgeInsets.only(left: AppSizes.size16, right: AppSizes.size8),
                hintText: "Search...",
                onChanged: (val){},
                controller: TextEditingController(),
              ),
            ),
            AppSizes.size8.width(),
            Row(
              spacing: AppSizes.size12,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: onGroupTap,
                  child: CommonIcon(
                    iconData: BoxIcons.bx_group,
                    iconSize: AppSizes.size32
                  ),
                )
              ]
            )
          ]
        )
      )
    );
  }
}