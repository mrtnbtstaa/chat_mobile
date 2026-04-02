import 'package:chat/core/style/app_colors.dart';
import 'package:chat/core/style/app_sizes.dart';
import 'package:flutter/material.dart';

class CommonLoadingIndicator extends SizedBox {

  final Color? indicatorColor;

  CommonLoadingIndicator({
    super.key,
    this.indicatorColor,
  }) : super(
    width: AppSizes.size24,
    height: AppSizes.size24,
    child: CircularProgressIndicator(
      color: indicatorColor ?? AppColors.lSurfaceLow,
      strokeWidth: 3.0,
    )
  );

}