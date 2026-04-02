import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../../core/common_widgets/common_icon.dart';
import '../../../../core/common_widgets/common_text.dart';
import '../../../../core/common_widgets/common_text_field.dart';
import '../../../../core/extensions/double_extension.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_insets.dart';
import '../../../../core/style/app_sizes.dart';

class PersonalInformationSection extends StatelessWidget {
const PersonalInformationSection({ super.key });

  @override
  Widget build(BuildContext context){
    return Column(
      children: <Widget>[
        AppSizes.size8.height(),
        Padding(
          padding: AppInsets.h32,
          child: Row(
            spacing: AppSizes.size8,
            children: <Widget>[
              CommonIcon(
                iconData: IonIcons.information_circle,
                iconColor: AppColors.primaryBrandColor,
              ),
              CommonText(
                text: "Personal Information",
                fontWeight: FontWeight.w500,
                letterSpacing: AppSizes.size2,
                fontSize: AppSizes.font16
              )
            ]
          )
        ),
        AppSizes.size32.height(),
        Padding(
          padding: AppInsets.h32,
          child: CommonTextField(
            text: "EMAIL ADDRESS",
            hintText: "martinbautista0288@outlook.com",
            onChanged: (val){},
            controller: TextEditingController(),
            fontColor: AppColors.ltextSecondary,
            fontSize: AppSizes.font12,
            suffixWidget: CommonIcon(
              iconData: IonIcons.shield_checkmark,
              iconColor: AppColors.primaryBrandColor
            )
          )
        )
      ]
    );
  }
}