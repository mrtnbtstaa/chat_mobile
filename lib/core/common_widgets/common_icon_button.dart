import 'package:chat/core/style/app_colors.dart';
import 'package:chat/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class CommonIconButton extends StatelessWidget {
  
  const CommonIconButton({ 
    super.key,
    this.onButtonPressed,
    this.iconColor,
    this.iconData
   });

  final VoidCallback? onButtonPressed;
  final IconData? iconData;
  final Color? iconColor;

  @override
  Widget build(BuildContext context){
    return IconButton(
      onPressed: () => onButtonPressed ?? context.pop(),
      icon: Icon(
        iconData ?? BoxIcons.bx_arrow_back,
        color: iconColor ??AppColors.primaryTextColor,
      )
    );
  }
}