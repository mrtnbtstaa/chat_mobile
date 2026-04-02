import 'package:chat/core/common_widgets/common_icon.dart';
import 'package:chat/core/common_widgets/common_text.dart';
import 'package:chat/core/style/app_colors.dart';
import 'package:chat/core/style/app_insets.dart';
import 'package:chat/core/style/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

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
    this.margin,
    this.child_,
    this.alignment,
    this.boxDecoration,
    this.withIcon = false,
    this.iconData,
    this.iconColor
  }) : super(
    onPressed: onButtonPressed,
    child: child_ ?? Container(
      alignment: alignment ?? Alignment.center,
      decoration: boxDecoration ?? BoxDecoration(
        color: backgroundColor ?? AppColors.primaryBrandColor,
        borderRadius: BorderRadius.circular(AppSizes.size16)
      ),
      padding: padding ?? EdgeInsets.zero,
      margin: margin ?? EdgeInsets.zero,
      width: width ?? 0.0,
      height: height ?? 0.0,
      child: !withIcon ? CommonText(
        text: text ?? "",
        fontColor: fontColor ?? AppColors.lSurfaceLow,
        fontSize: fontSize ?? AppSizes.size16,
        fontWeight: fontWeight ?? FontWeight.w500,
      ) : Row(
        spacing: AppSizes.spacing8,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CommonIcon(
            iconData: iconData ?? FontAwesome.google_brand,
            iconSize: AppSizes.size32,
            iconColor: iconColor ?? AppColors.ltextPrimary,
          ),
          CommonText(
            text: text ?? "",
            fontColor: fontColor ?? AppColors.lSurfaceLow,
            fontSize: fontSize ?? AppSizes.size16,
            fontWeight: fontWeight ?? FontWeight.w500,
          )
        ],
      ),
    ),
    style: ElevatedButton.styleFrom(
      elevation: elevation ?? 0.0,  
      overlayColor: overlayColor ?? AppColors.lSurfaceMedium,
      padding: elevatedPadding ?? AppInsets.h8,
      splashFactory: splashFactory ?? InkRipple.splashFactory,
      backgroundColor:Colors.transparent,
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
  final Widget? child_;
  final AlignmentGeometry? alignment;
  final BoxDecoration? boxDecoration;
  final bool withIcon;
  final IconData? iconData;
  final Color? iconColor;

}