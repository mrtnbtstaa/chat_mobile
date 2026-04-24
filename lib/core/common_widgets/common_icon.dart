import 'package:chat/core/extensions/context_extension.dart';
import 'package:chat/core/style/app_colors.dart';
import 'package:flutter/material.dart';

class CommonIcon extends StatelessWidget {

  const CommonIcon({ 
    super.key,
    this.iconData,
    this.iconColor,
    this.iconSize
   });

  @override
  Widget build(BuildContext context){
    return Icon(
      iconData,
      color: iconColor ?? (context.isDarkMode ? AppColors.dTextSecondary : AppColors.ltextSecondary),
      size: iconSize,
    );
  }

  final IconData? iconData;
  final Color? iconColor;
  final double? iconSize;

}

