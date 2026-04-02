import 'package:chat/core/style/app_colors.dart';
import 'package:chat/core/style/app_insets.dart';
import 'package:chat/core/style/app_sizes.dart';
import 'package:flutter/material.dart';

class StatusIndicator extends Padding{

  final Color? indicatorColor;
  final double? size;
  StatusIndicator({
    super.key,
    this.indicatorColor,
    this.size
  }) : super(
    padding: AppInsets.v8,
    child: Container(
      width: size ?? AppSizes.size16,
      height: size ?? AppSizes.size16,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: indicatorColor ?? AppColors.ltextPrimary
      )
    )
  );
}