import 'package:chat/core/style/app_colors.dart';
import 'package:chat/core/style/app_sizes.dart';
import 'package:flutter/material.dart';

class CommonDivider extends Divider{

  CommonDivider({
    super.key,
    this.color_,
    this.thickness_,
    this.indent_,
    this.endIndent_
  }) : super(
    color: color_ ?? AppColors.primaryTextColor.withValues(alpha: 0.1),
    thickness: thickness_ ?? AppSizes.size2,
    indent: indent_,
    endIndent: endIndent_
  );

  final Color? color_;
  final double? thickness_;
  final double? indent_;
  final double? endIndent_;

}