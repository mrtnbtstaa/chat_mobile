import 'package:chat/core/style/app_colors.dart';
import 'package:chat/core/style/app_sizes.dart';
import 'package:flutter/material.dart';

class CommonDivider extends Divider{

  const CommonDivider({
    super.key,
    this.color_,
    this.thickness_,
    this.indent_,
    this.endIndent_
  }) : super(
    color: color_ ?? AppColors.lBorderDivider,
    thickness: thickness_ ?? AppSizes.size2,
    indent: indent_ ?? AppSizes.size16,
    endIndent: endIndent_ ?? AppSizes.size16
  );

  final Color? color_;
  final double? thickness_;
  final double? indent_;
  final double? endIndent_;

}