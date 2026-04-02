import 'package:chat/core/common_widgets/common_container.dart';

import '../../../../core/common_widgets/common_icon.dart';
import '../../../../core/common_widgets/common_text.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_insets.dart';
import '../../../../core/style/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class ApplicationContent extends StatelessWidget {

  final String? title;
  final String? description;
  final IconData? iconData;
  final Color? iconColor;
  final Function()? onTap;

  const ApplicationContent({ 
    super.key,
    this.title,
    this.description,
    this.iconData,
    this.iconColor,
    required this.onTap
   });

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: onTap,
      child: CommonContainer(
        padding: EdgeInsets.zero,
        child: ListTile(
          leading: CommonContainer(
            padding: AppInsets.a8,
            borderRadius: AppSizes.size8,
            child: CommonIcon(
              iconData: iconData ?? BoxIcons.bxs_palette,
              iconColor:iconColor ?? AppColors.primaryBrandColor,
              iconSize: AppSizes.size32
            ),
          ),
          title: CommonText(
            text: title ?? "Appearance",
            fontWeight: FontWeight.w700,
          ),
          subtitle: CommonText(
            text: description ?? "Theme, wallpapers, text size",
          ),
          trailing: CommonIcon(iconData: BoxIcons.bx_chevron_right)
        )
      )
    );
  }
}