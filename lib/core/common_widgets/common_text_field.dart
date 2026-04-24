import 'package:chat/core/common_widgets/common_container.dart';
import 'package:chat/core/common_widgets/common_icon.dart';
import 'package:chat/core/common_widgets/common_text.dart';
import 'package:chat/core/extensions/context_extension.dart';
import 'package:chat/core/style/app_colors.dart';
import 'package:chat/core/style/app_insets.dart';
import 'package:chat/core/style/app_sizes.dart';
import 'package:chat/core/extensions/int_extension.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class CommonTextField extends StatelessWidget {

  const CommonTextField({ 
    super.key,
    this.hintText,
    required this.onChanged,
    required this.controller,
    this.isObsecure = false,
    this.text,
    this.fontColor,
    this.fontWeight,
    this.initialValue,
    this.fontSize,
    this.prefixIconWidget,
    this.iconSuffixData,
    this.onSuffixButtonPressed,
    this.textInputAction,
    this.textInputType,
    this.width,
    this.height,
    this.padding,
    this.contentPadding,
    this.errorText = "",
    this.validator,
    this.suffixWidget,
    this.prefixIconColor,
    this.suffixIconColor,
    this.prefixIconData,
    this.isReadOnly = false
   });


  @override
  Widget build(BuildContext context){

    if(text != null){
      return SizedBox(
        width: width,
        height: height,
        child: Column(
          spacing: AppSizes.size8,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CommonText(
              text: text ?? "",
              alignment: TextAlign.left,
              letterSpacing: AppSizes.size2,
              fontWeight: fontWeight ?? FontWeight.w600,
              fontColor: context.isDarkMode ? AppColors.dTextSecondary : AppColors.ltextSecondary,
              fontSize: fontSize,
            ),
            CommonContainer(
              padding: padding ?? AppInsets.hv4,
              child: TextFormField(
                readOnly: isReadOnly,
                initialValue: initialValue,
                controller: controller,
                validator: validator,
                style: TextStyle(
                  color: context.isDarkMode ? AppColors.dTextSecondary : AppColors.ltextSecondary
                ),
                textInputAction: textInputAction ?? TextInputAction.next,
                keyboardType: textInputType ?? TextInputType.text,
                onChanged: onChanged,
                obscureText: isObsecure,
                decoration: InputDecoration(
                  contentPadding: contentPadding ?? EdgeInsets.only(left: AppSizes.size8),
                  prefixIcon: prefixIconWidget ?? CommonIcon(
                    iconData: prefixIconData ?? IonIcons.search,
                    iconColor: prefixIconColor ?? (context.isDarkMode ? AppColors.dTextSecondary : AppColors.ltextSecondary),
                  ),
                  suffixIcon: IconButton(
                    onPressed: onSuffixButtonPressed,
                    icon: Icon(iconSuffixData, color: suffixIconColor ?? (context.isDarkMode ? AppColors.primaryBrandColor : AppColors.ltextSecondary)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(AppSizes.size16)),
                    borderSide: BorderSide(
                      color: Colors.transparent
                    )
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(AppSizes.size16)),
                    borderSide: BorderSide(
                      color: Colors.transparent
                    )
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(AppSizes.size16)),
                    borderSide: BorderSide(
                      color: AppColors.white100
                    )
                  ),
                  errorBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  hintText: hintText,
                  hintStyle: TextStyle(
                    letterSpacing: AppSizes.size2,
                    fontSize: AppSizes.font14,
                    color: context.isDarkMode ? AppColors.dTextSecondary : AppColors.ltextSecondary
                  ),
                  hintFadeDuration: 1000.milliseconds(),
                  fillColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent
                )
              )
            ),
            Padding(
              padding: AppInsets.h8,
              child: Align(
                alignment: Alignment.centerLeft,
                child: CommonText(
                  text: errorText,
                  fontColor: AppColors.error,
                )
              ),
            )
          ]
        )
      );
    }

    return SizedBox(
      width: width,
      height: height,
      child: CommonContainer(
        padding: padding ?? AppInsets.hv4,
        child: TextFormField(
          controller: controller,
          validator: validator,
          style: TextStyle(
            color: context.isDarkMode ? AppColors.dTextSecondary : AppColors.ltextSecondary
          ),
          textInputAction: textInputAction ?? TextInputAction.next,
          keyboardType: textInputType ?? TextInputType.text,
          onChanged: onChanged,
          obscureText: isObsecure,
          decoration: InputDecoration(
            contentPadding: contentPadding ?? EdgeInsets.zero,
            prefixIcon: prefixIconWidget ?? CommonIcon(
              iconData: prefixIconData ?? IonIcons.search,
              iconColor: prefixIconColor ?? (context.isDarkMode ? AppColors.dTextSecondary : AppColors.ltextSecondary),
            ),
            suffixIcon: IconButton(
              onPressed: onSuffixButtonPressed,
              icon: Icon(iconSuffixData, color: suffixIconColor ?? (context.isDarkMode ? AppColors.primaryBrandColor : AppColors.ltextSecondary)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(AppSizes.size16)),
              borderSide: BorderSide(
                color: Colors.transparent
              )
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(AppSizes.size16)),
              borderSide: BorderSide(
                color: Colors.transparent
              )
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(AppSizes.size16)),
              borderSide: BorderSide(
                color: AppColors.white100
              )
            ),
            errorBorder: InputBorder.none,
            hintText: hintText,
            hintStyle: TextStyle(
              letterSpacing: AppSizes.size2,
              fontSize: AppSizes.font14,
              color: context.isDarkMode ? AppColors.dTextSecondary : AppColors.ltextSecondary
            ),
            hintFadeDuration: 1000.milliseconds(),
            focusedErrorBorder: InputBorder.none,
            errorStyle: TextStyle(color: AppColors.error),
            filled: true,
            fillColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent
          )
        )
      )
    );
  }

  final String? hintText;
  final bool isObsecure;
  final String? text;
  final String? initialValue;
  final Color? fontColor;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Function(String)? onChanged;
  final TextEditingController controller;
  final Widget? prefixIconWidget;
  final IconData? iconSuffixData;
  final VoidCallback? onSuffixButtonPressed;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? contentPadding;
  final String errorText;
  final String? Function(String?)? validator;
  final Widget? suffixWidget;
  final IconData? prefixIconData;
  final Color? prefixIconColor;
  final Color? suffixIconColor;
  final bool isReadOnly;
}