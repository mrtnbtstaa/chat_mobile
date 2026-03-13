import 'package:chat/core/common_widgets/common_text.dart';
import 'package:chat/core/common_widgets/glass_container.dart';
import 'package:chat/core/constants/app_colors.dart';
import 'package:chat/core/constants/app_insets.dart';
import 'package:chat/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class CommonElevatedButton extends ElevatedButton{
  
  CommonElevatedButton({
    super.key,
    this.onButtonPressed,
    this.text,
    this.elevation,
    this.overlayColor,
    this.elevatedPadding,
    this.splashFactory,
    this.backgroundColor,
    this.shadowColor,
    this.fontColor,
    this.border,
    this.borderSide,
    this.borderColor,
    this.fontSize,
    this.fontWeight,
    this.width,
    this.height,
    this.padding,
    this.margin
  }) : super(
    onPressed: onButtonPressed,
    child: GlassContainer(
      padding: padding ?? EdgeInsets.zero,
      margin: margin ?? EdgeInsets.zero,
      width: width ?? 0.0,
      height: height ?? 0.0,
      child: CommonText(
        text: text ?? "",
        fontColor: fontColor ?? AppColors.primaryTextColor,
        fontSize: fontSize ?? AppSizes.size24,
        fontWeight: fontWeight ?? FontWeight.w500,
      ),
    ),
    style: ElevatedButton.styleFrom(
      elevation: elevation ?? 0.0,  
      overlayColor: overlayColor ?? AppColors.bgColor,
      padding: elevatedPadding ?? AppInsets.h8,
      splashFactory: splashFactory ?? InkRipple.splashFactory,
      backgroundColor: backgroundColor ?? Colors.transparent,
      shadowColor: shadowColor ?? Colors.transparent,
      shape: border ?? RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(AppSizes.size16))
    )
  );
  
  final VoidCallback? onButtonPressed;
  final String? text;
  final double? elevation;
  final Color? overlayColor;
  final EdgeInsetsGeometry? elevatedPadding;
  final InteractiveInkFeatureFactory? splashFactory;
  final Color? backgroundColor;
  final Color? shadowColor;
  final Color? fontColor;
  final OutlinedBorder? border;
  final BorderSide? borderSide;
  final Color? borderColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

}