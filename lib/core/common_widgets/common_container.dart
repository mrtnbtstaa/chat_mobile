import 'package:chat/core/extensions/context_extension.dart';
import 'package:chat/core/style/app_insets.dart';
import 'package:chat/core/style/app_sizes.dart';
import 'package:flutter/material.dart';

class CommonContainer extends StatelessWidget {

  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final Color? backgroundColor;
  final double? width;
  final double? height;
  final BoxDecoration? boxDecoration;
  final BoxShape shape;
  final BorderRadiusGeometry? radiusGeometry;

  const CommonContainer({
    super.key,
    this.child,
    this.padding,
    this.borderRadius,
    this.backgroundColor,
    this.width,
    this.height,
    this.boxDecoration,
    this.radiusGeometry,
    this.shape = BoxShape.rectangle
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding ?? AppInsets.a16,
      decoration: boxDecoration ?? BoxDecoration(
        shape: shape,
        color: backgroundColor ?? context.currentTheme.cardTheme.color, 
        borderRadius: radiusGeometry ?? BorderRadius.circular(borderRadius ?? AppSizes.size16),
      ),
      child: child,
    );
  }
}