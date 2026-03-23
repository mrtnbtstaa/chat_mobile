import 'package:chat/core/common_widgets/common_icon.dart';
import 'package:chat/core/common_widgets/common_text.dart';
import 'package:chat/core/common_widgets/glass_container.dart';
import 'package:chat/core/style/app_sizes.dart';
import 'package:flutter/material.dart';

class CommonShowDialog extends Dialog{

  final AlignmentGeometry? alignmentGeometry;
  final EdgeInsets? edgeInsetPadding;
  final String title;
  final String description;
  final IconData iconData;
  final Color? iconColor;
  final double height;

  CommonShowDialog({
    super.key,
    this.alignmentGeometry,
    this.edgeInsetPadding,
    this.iconColor,
    required this.title,
    required this.description,
    required this.iconData,
    required this.height
  }) : super(
    alignment: alignmentGeometry,
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    insetPadding: edgeInsetPadding ?? EdgeInsets.zero,
    child: GlassContainer(
      height: height,
      child: Column(
        spacing: AppSizes.spacing16,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CommonIcon(
            iconData: iconData,
            iconColor: iconColor,
            iconSize: AppSizes.size124,
          ),
          CommonText(
            text: title,
            fontSize: AppSizes.font32,
            fontWeight: FontWeight.w900,
          ),
          SizedBox(
            width: 320.0,
            child: CommonText(
              text: description,
              alignment: TextAlign.center,
              fontSize: AppSizes.font16,
            ),
          )
        ],
      ),
    )
  );

}