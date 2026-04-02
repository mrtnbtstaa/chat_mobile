import 'package:chat/core/extensions/context_extension.dart';
import 'package:chat/core/style/app_sizes.dart';
import 'package:flutter/material.dart';

import 'common_container.dart';

class CommonTextShimmering extends StatelessWidget {

  final EdgeInsetsGeometry? padding;
  final double? width; 
  final double? height; 
  final double? borderRadius; 

  const CommonTextShimmering({ 
    super.key,
    this.padding,
    this.width,
    this.height,
    this.borderRadius
   });

  @override
  Widget build(BuildContext context){
    return CommonContainer(
      padding: padding ?? EdgeInsets.zero,
      width: width ??AppSizes.size64 - 4,
      height: height ?? AppSizes.size12,
      boxDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? AppSizes.size8),
        color: context.currentTheme.cardTheme.color?.withValues(alpha: 0.8), 
      ),
    );
  }
}