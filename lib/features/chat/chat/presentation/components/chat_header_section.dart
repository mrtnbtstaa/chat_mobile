import '../../../../../core/common_widgets/common_avatar.dart';
import '../../../../../core/router/app_routes.dart';
import 'package:go_router/go_router.dart';

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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () => context.go(AppRoutes.profile),
              child: CommonAvatar(path: AppImages.profile),
            ),
            Expanded(
              child: CommonTextField(
                padding: EdgeInsets.only(left: AppSizes.size8),
                contentPadding: EdgeInsets.only(top: 12.0, bottom: 12.0),
                hintText: "Search...",
                onChanged: (val){},
                controller: TextEditingController(),
              ),
            ),
            AppSizes.size8.width(),
            GestureDetector(
              onTap: onGroupTap,
              child: CommonIcon(
                iconData: BoxIcons.bx_group,
                iconSize: AppSizes.size32
              ),
            )
          ]
        )
      )
    );
  }
}