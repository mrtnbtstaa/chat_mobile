import 'package:chat/core/style/app_colors.dart';
import 'package:flutter/material.dart';

class CommonContainer extends StatelessWidget {

  const CommonContainer({ 
    super.key,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.boxDecoration,
    this.child,
    this.clip = Clip.none,
    this.alignmentGeometry
   });

  final double? width;
  final double? height;
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BoxDecoration? boxDecoration;
  final Clip clip;
  final AlignmentGeometry? alignmentGeometry;


  @override
  Widget build(BuildContext context){
    return Container(
      alignment: alignmentGeometry ?? Alignment.center,
      clipBehavior: clip,
      width: width,
      height: height,
      padding: padding ?? EdgeInsets.zero,
      margin: margin ?? EdgeInsets.zero,
      decoration: boxDecoration ?? BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.bgColor01.withValues(alpha: 0.8),
            AppColors.bgColor.withValues(alpha: 0.9),
          ],
        )
      ),
      child: child,
    );
  }
}