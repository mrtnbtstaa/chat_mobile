import 'dart:ui';

import 'package:chat/core/extensions/context_extension.dart';

import 'common_icon.dart';
import 'common_text.dart';
import '../style/app_colors.dart';
import '../style/app_sizes.dart';
import 'package:flutter/material.dart';
import 'common_container.dart';

class CommonShowDialog extends StatelessWidget {
  
  const CommonShowDialog({
    super.key,
    this.alignmentGeometry,
    this.edgeInsetPadding,
    this.iconColor,
    required this.title,
    required this.description,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: AppSizes.size8,
        sigmaY: AppSizes.size8,
      ),
      child: Dialog(
        alignment: alignmentGeometry,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        insetPadding: edgeInsetPadding ?? EdgeInsets.zero,
        child: CommonContainer(
          height: context.height / 4,
          child: Column(
            spacing: AppSizes.spacing16,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                spacing: AppSizes.size16,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CommonContainer(
                    boxDecoration: BoxDecoration(
                      color: AppColors.primaryBrandColor,
                      shape: BoxShape.circle,
                    ),
                    child: CommonIcon(
                      iconData: iconData,
                      iconColor: AppColors.lSurfaceLow,
                      iconSize: AppSizes.size32,
                    )
                  ),
                  Column(
                    spacing: AppSizes.spacing8,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CommonText(
                        text: title,
                        fontSize: AppSizes.font24,
                        fontWeight: FontWeight.w900,
                      ),
                      SizedBox(
                        width: context.width / 1.6,
                        child: CommonText(
                          text: description,
                          alignment: TextAlign.start,
                          fontSize: AppSizes.font16
                        ),
                      )
                    ]
                  )
                ]
              )
            ]
          )
        )
      ),
    );
  }

  final AlignmentGeometry? alignmentGeometry;
  final EdgeInsets? edgeInsetPadding;
  final String title;
  final String description;
  final IconData iconData;
  final Color? iconColor;
}
