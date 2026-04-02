import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import '../../../../../core/common_widgets/common_icon.dart';
import '../../../../../core/style/app_colors.dart';
import '../../../../../core/style/app_images.dart';
import '../../../../../core/style/app_insets.dart';
import '../../../../../core/style/app_sizes.dart';

class GroupAvatarSection extends StatelessWidget {

  final Function()? onTap;

  const GroupAvatarSection({ 
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
          Container(
            width: AppSizes.size64 * 2,
            height: AppSizes.size64 * 2,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.mountain),
                fit: BoxFit.cover
              ),
              border: Border.all(
                color: AppColors.lSurfaceLow,
                width: AppSizes.size2
              ),
              shape: BoxShape.circle
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
                iconColor: AppColors.lSurfaceLow
              )
            )
          )
        ]
      )
    );
  }
}