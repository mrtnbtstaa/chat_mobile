import 'package:chat/core/di/di.dart';
import 'package:chat/core/di/di_exports.dart';
import 'package:chat/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../../../core/common_widgets/common_icon.dart';
import '../../../../../core/common_widgets/common_text.dart';
import '../../../../../core/common_widgets/common_text_field.dart';
import '../../../../../core/extensions/double_extension.dart';
import '../../../../../core/style/app_colors.dart';
import '../../../../../core/style/app_insets.dart';
import '../../../../../core/style/app_sizes.dart';

class PersonalInformationSection extends HookWidget {
const PersonalInformationSection({ super.key });

  @override
  Widget build(BuildContext context){

    final emailController = useTextEditingController();

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
        FutureBuilder(
          future: sl<IUserStorage>().getUserInfo("email"),
          builder: (context, asyncSnapshot) {

            if(asyncSnapshot.hasError){
              return CommonIcon(iconData: Icons.error);
            }

            final email = asyncSnapshot.data;

            if(email != null){
              emailController.text = email.capitalize;
            }

            return Padding(
              padding: AppInsets.h32,
              child: CommonTextField(
                text: "EMAIL ADDRESS",
                hintText: "alex@example.com",
                onChanged: (val){},
                controller: emailController,
                fontColor: AppColors.ltextSecondary,
                fontSize: AppSizes.font12,
                suffixWidget: CommonIcon(
                  iconData: IonIcons.shield_checkmark,
                  iconColor: AppColors.primaryBrandColor
                ),
                isReadOnly: true,
              )
            );
          }
        )
      ]
    );
  }
}