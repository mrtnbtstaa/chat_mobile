import 'package:chat/core/style/app_colors.dart';
import 'package:chat/core/style/app_sizes.dart';
import 'package:flutter/material.dart';

class CommonText extends Text {
  
  CommonText({
    super.key,
    required this.text,
    this.fontColor,
    this.fontWeight,
    this.fontSize,
    this.alignment,
    this.textDecoration,
    this.letterSpacing,
    this.wordSpacing,
    this.decorationColor,
    this.textOverflow,
    this.maxLine,
    this.wrap
  }) : super(
    text,
    maxLines: maxLine,
    softWrap: wrap,
    style: TextStyle(
      color: fontColor ?? AppColors.primaryTextColor,
      fontWeight: fontWeight,
      fontSize: fontSize ?? AppSizes.font14,
      decorationColor: decorationColor,
      letterSpacing: letterSpacing ?? 1.0,
      wordSpacing: wordSpacing,
      overflow: textOverflow,
      decoration: textDecoration
    ),
    textAlign: alignment,
  );

  final String text;
  final Color? fontColor;
  final FontWeight? fontWeight;
  final double? fontSize;
  final TextAlign? alignment;
  final TextDecoration? textDecoration;
  final double? letterSpacing;
  final double? wordSpacing;
  final Color? decorationColor;
  final TextOverflow? textOverflow;
  final int? maxLine;
  final bool? wrap;

}