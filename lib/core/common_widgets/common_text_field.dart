import 'package:chat/core/common_widgets/common_text.dart';
import 'package:chat/core/common_widgets/glass_container.dart';
import 'package:chat/core/style/app_colors.dart';
import 'package:chat/core/style/app_insets.dart';
import 'package:chat/core/style/app_sizes.dart';
import 'package:chat/core/extensions/int_extension.dart';
import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {

  const CommonTextField({ 
    super.key,
    required this.hintText,
    required this.onChanged,
    required this.controller,
    this.isObsecure = false,
    this.text,
    this.prefixIconWidget,
    this.hasSuffixIcon = false,
    this.iconSuffixData,
    this.onSuffixButtonPressed,
    this.textInputAction,
    this.textInputType,
    this.width,
    this.height,
    this.padding,
    this.contentPadding,
    this.errorText = "",
    this.validator
   });


  @override
  Widget build(BuildContext context){

    if(text != null){
      return SizedBox(
        width: width,
        height: height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: AppInsets.h8,
              child: CommonText(
                text: text ?? "",
                alignment: TextAlign.left,
                letterSpacing: AppSizes.size2,
                fontWeight: FontWeight.w500,
                fontColor: AppColors.primaryTextColor,
              ),
            ),
            GlassContainer(
              padding: padding ?? AppInsets.hv4,
              child: TextFormField(
                controller: controller,
                validator: validator,
                style: TextStyle(
                  color: AppColors.primaryTextColor
                ),
                textInputAction: textInputAction ?? TextInputAction.next,
                keyboardType: textInputType ?? TextInputType.text,
                onChanged: onChanged,
                obscureText: isObsecure,
                decoration: InputDecoration(
                  contentPadding: contentPadding ?? EdgeInsets.zero,
                  prefixIcon: prefixIconWidget,
                  suffixIcon: hasSuffixIcon ? IconButton(
                    onPressed: onSuffixButtonPressed,
                    icon: Icon(iconSuffixData, color: AppColors.primaryTextColor),
                  ) : SizedBox.shrink(),
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
                      color: AppColors.secondaryColor
                    )
                  ),
                  errorBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  hintText: hintText,
                  hintStyle: TextStyle(
                    letterSpacing: AppSizes.size2,
                    fontSize: AppSizes.font14,
                    color: AppColors.primaryTextColor
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
                  fontColor: AppColors.primaryTextColor.withValues(alpha: 0.7)
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
      child: GlassContainer(
        padding: padding ?? AppInsets.hv8,
        child: TextFormField(
          controller: controller,
          validator: validator,
          style: TextStyle(
            color: AppColors.primaryTextColor
          ),
          textInputAction: textInputAction ?? TextInputAction.next,
          keyboardType: textInputType ?? TextInputType.text,
          onChanged: onChanged,
          obscureText: isObsecure,
          decoration: InputDecoration(
            contentPadding: contentPadding ?? EdgeInsets.zero,
            prefixIcon: prefixIconWidget,
            suffixIcon: hasSuffixIcon ? IconButton(
              onPressed: onSuffixButtonPressed,
              icon: Icon(iconSuffixData, color: AppColors.primaryTextColor),
            ) : SizedBox.shrink(),
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
                color: AppColors.secondaryColor
              )
            ),
            errorBorder: InputBorder.none,
            hintText: hintText,
            hintStyle: TextStyle(
              letterSpacing: AppSizes.size2,
              fontSize: AppSizes.font14,
              color: AppColors.primaryTextColor
            ),
            hintFadeDuration: 1000.milliseconds(),
            focusedErrorBorder: InputBorder.none,
            errorStyle: TextStyle(color: AppColors.bgColor02),
            filled: true,
            fillColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent
          )
        )
      )
    );
  }

  final String hintText;
  final bool isObsecure;
  final String? text;
  final Function(String)? onChanged;
  final TextEditingController controller;
  final Widget? prefixIconWidget;
  final bool hasSuffixIcon;
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
}