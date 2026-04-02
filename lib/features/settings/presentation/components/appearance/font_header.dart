import 'package:chat/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

import '../../../../../core/common_widgets/common_text.dart';
import '../../../../../core/common_widgets/partition_divider.dart';
import '../../../../../core/extensions/double_extension.dart';
import '../../../../../core/style/app_colors.dart';
import '../../../../../core/style/app_insets.dart';
import '../../../../../core/style/app_sizes.dart';

class FontHeader extends StatelessWidget {
const FontHeader({ super.key });

  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        CommonText(
          text: "ACCESSBILITY",
          fontWeight: FontWeight.w500,
        ),
        CommonText(
          text: "Text Size",
          fontSize: AppSizes.font32,
          fontWeight: FontWeight.bold,
        ),
        Padding(
          padding: AppInsets.h8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              CommonText(
                text: "A",
                fontSize: AppSizes.size16,
                fontWeight: FontWeight.w500,
              ),
              PartitionDivider(dividerColor: context.currentTheme.dividerColor,),
              PartitionDivider(dividerColor: context.currentTheme.dividerColor,),
              PartitionDivider(dividerColor: context.currentTheme.dividerColor,),
              CommonText(
                text: "A",
                fontSize: AppSizes.size24,
                fontWeight: FontWeight.w800
              )
            ]
          )
        ),
        AppSizes.size8.height(),
      ]
    );
  }
}