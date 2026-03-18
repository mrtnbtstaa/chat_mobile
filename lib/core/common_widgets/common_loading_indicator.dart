import 'package:chat/core/style/app_colors.dart';
import 'package:chat/core/style/app_sizes.dart';
import 'package:flutter/material.dart';

class CommonLoadingIndicator extends SizedBox {

  CommonLoadingIndicator({
    super.key,
  }) : super(
    width: AppSizes.size24,
    height: AppSizes.size24,
    child: CircularProgressIndicator(
      color: AppColors.primaryTextColor.withValues(alpha: 0.5),
      strokeWidth: 3.0,
    )
  );

}