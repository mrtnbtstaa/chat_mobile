import 'package:chat/core/extensions/int_extension.dart';

import '../../../../../core/common_widgets/common_icon.dart';
import '../../../../../core/common_widgets/common_image.dart';
import '../../../../../core/common_widgets/common_text.dart';
import '../../../../../core/style/app_colors.dart';
import '../../../../../core/style/app_images.dart';
import '../../../../../core/style/app_insets.dart';
import '../../../../../core/style/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class ThemeButtonContent extends StatelessWidget {

  final bool value;
  final String text;
  final Function()? onTap;

  const ThemeButtonContent({ 
    super.key,
    required this.value,
    required this.text,
    required this.onTap
   });  

  @override
  Widget build(BuildContext context){
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          spacing: AppSizes.spacing4,
          children: <Widget>[
            Stack(
              children: <Widget>[
                AnimatedContainer(
                  duration: 100.milliseconds(),
                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: value ? AppColors.primaryBrandColor : Colors.transparent,
                      width: AppSizes.size4 - 1
                    ),
                    borderRadius: BorderRadius.circular(AppSizes.size20)
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppSizes.size16),
                    child: CommonImage(
                      image: AssetImage(AppImages.mountain)
                    ),
                  ),
                ),
                value ? Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding: AppInsets.a4,
                    decoration: BoxDecoration(
                      color: AppColors.primaryBrandColor,
                      shape: BoxShape.circle
                    ),
                    child: CommonIcon(
                      iconData: BoxIcons.bx_check,
                      iconColor: AppColors.lSurfaceLow,
                    )
                  ),
                ) : SizedBox.shrink()
              ],
            ),
            
            CommonText(
              text: text,
              fontWeight: value ? FontWeight.bold : FontWeight.normal,
            )
          ],
        ),
      ),
    );
  }
}