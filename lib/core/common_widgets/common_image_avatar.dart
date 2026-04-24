import 'dart:ui';

import 'package:chat/core/common_widgets/common_icon.dart';
import 'package:chat/core/style/app_colors.dart';
import 'package:chat/core/style/app_images.dart';
import 'package:chat/core/style/app_insets.dart';
import 'package:chat/core/style/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class CommonImageAvatar extends StatelessWidget {

  final Function()? onTap;

  const CommonImageAvatar({ 
    super.key,
    required this.onTap
   });

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: <Widget>[
          ClipPath(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 6.0,
                sigmaY: 6.0
              ),
              child: Container(
                width: AppSizes.size64 * 2,
                height: AppSizes.size64 * 2,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppImages.profile),
                    fit: BoxFit.cover
                  ),
                  border: Border.all(
                    color: AppColors.lSurfaceLow,
                    width: AppSizes.size2
                  ),
                  shape: BoxShape.circle
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              padding: AppInsets.a8,
              decoration: BoxDecoration(
                color: AppColors.primaryBrandColor,
                shape: BoxShape.circle
              ),
              child: CommonIcon(
                iconData: IonIcons.camera,
                iconColor: AppColors.lSurfaceLow,
              ),
            ),
          )
        ]
      ),
    );
  }
}