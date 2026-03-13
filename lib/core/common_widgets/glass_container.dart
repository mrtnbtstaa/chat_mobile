import 'dart:ui';

import '../constants/app_sizes.dart';
import 'package:flutter/material.dart';

class GlassContainer extends StatelessWidget {

  const GlassContainer({ 
    super.key,
    this.width,
    this.height,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadiusGeometry,
    this.colorOne,
    this.colorTwo,
    this.colorThree,
    this.alignmentGeometry,
    this.sigmaX,
    this.sigmaY,
   });

  final double? width;
  final double? height;
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadiusGeometry? borderRadiusGeometry;
  final Color? colorOne;
  final Color? colorTwo;
  final Color? colorThree;
  final AlignmentGeometry? alignmentGeometry;
  final double? sigmaX;
  final double? sigmaY;

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: ClipRRect(
        borderRadius: borderRadiusGeometry ?? BorderRadiusGeometry.circular(AppSizes.size16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: sigmaX ?? 6.0, sigmaY: sigmaY ?? 6.0),
          child: Container(
            alignment: alignmentGeometry ?? Alignment.center,
            padding: padding ?? EdgeInsets.zero,
            margin: margin ?? EdgeInsets.zero,
            width: width,
            height: height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  colorOne ?? Colors.white.withValues(alpha: 0.2),
                  colorTwo ?? Colors.white.withValues(alpha: 0.01),
                  colorThree ?? Colors.white.withValues(alpha: 0.02),
                ]
              ),
              borderRadius: borderRadiusGeometry ?? BorderRadius.circular(AppSizes.size16),
              border: Border.all(color: Colors.white.withValues(alpha: 0.2), width: 1.5)
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}