import 'package:chat/core/style/app_colors.dart';
import 'package:flutter/material.dart';

class PartitionDivider extends Container {

  final Color? dividerColor;

  PartitionDivider({
    super.key,
    this.dividerColor
  }) : super(
    height: 25.0,
    width: 2.0,
    color: dividerColor ?? AppColors.ltextSecondary.withValues(alpha: 0.1),
  );

}

