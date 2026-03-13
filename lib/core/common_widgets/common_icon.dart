import 'package:chat/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CommonIcon extends Icon {

  const CommonIcon({
    super.key,
    this.iconData,
    this.iconColor,
    this.iconSize
  }) : super(
    iconData,
    color: iconColor ?? AppColors.primaryTextColor,
    size: iconSize
  );

  final IconData? iconData;
  final Color? iconColor;
  final double? iconSize;

}