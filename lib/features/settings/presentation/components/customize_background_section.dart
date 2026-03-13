import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../../core/common_widgets/common_image.dart';
import '../../../../core/common_widgets/common_text.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/constants/app_insets.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/extensions/double_extension.dart';
import 'setting_list_tile.dart';
import 'settings_switcher.dart';

class CustomizeBackgroundSection extends StatelessWidget {
const CustomizeBackgroundSection({ super.key });

  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        Padding(
          padding: AppInsets.h16,
          child: Align(
            alignment: Alignment.centerLeft,
            child: CommonText(
              text: "Customize Background",
              fontWeight: FontWeight.bold,
              fontSize: AppSizes.font16,
            )
          )
        ),
        AppSizes.size8.height(),
        Column(
          spacing: AppSizes.spacing16,
          children: [
            SettingListTile(
              iconData: Icons.image,
              text: "Choose Background",
              onTap: (){},
              withTrailing: true,
              trailing: Flexible(
                child: Padding(
                  padding: AppInsets.v4,
                  child: ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(AppSizes.size8),
                    child: CommonImage(
                      image: AssetImage(AppImages.mountain)
                    )
                  )
                )
              )
            ),
            SettingsSwitcher(
              iconData: Icons.sunny,
              text: "Blur Effect",
              onTap: (){},
            ),
            SettingsSwitcher(
              iconData: BoxIcons.bx_glasses,
              text: "Enable Glass Effect",
              onTap: (){},
            ),
            SettingsSwitcher(
              iconData: BoxIcons.bx_color,
              text: "Customize Glass Color",
              onTap: (){},
            )
          ]
        )
      ]
    );
  }
}