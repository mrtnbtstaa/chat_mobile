import 'package:flutter/material.dart';
import '../extensions/context_extension.dart';
import '../style/app_sizes.dart';

class CommonText extends StatelessWidget {

  const CommonText({ 
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
  });

  @override
  Widget build(BuildContext context){
    return Text(
      text,
      style: TextStyle(
        color: fontColor ?? context.textTheme.bodyMedium?.color,
        fontWeight: fontWeight,
        fontSize: fontSize ?? AppSizes.font14,
        decorationColor: decorationColor,
        letterSpacing: letterSpacing ?? 1.0,
        wordSpacing: wordSpacing,
        overflow: textOverflow,
        decoration: textDecoration
      ),
      textAlign: alignment,
      maxLines: maxLine,
      softWrap: wrap,
    );
  }

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

