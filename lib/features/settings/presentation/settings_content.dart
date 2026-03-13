import 'package:flutter/material.dart';

import '../../../core/common_widgets/common_container_background.dart';
import '../../../core/common_widgets/common_scaffold.dart';
import '../../../core/common_widgets/glass_container.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/extensions/double_extension.dart';
import 'components/customize_background_section.dart';
import 'components/settings_header_section.dart';
import 'components/settings_section.dart';

class SettingsContent extends StatelessWidget {
const SettingsContent({ super.key });

  @override
  Widget build(BuildContext context){
    return CommonScaffold(
      body: Stack(
        children: <Widget>[
          CommonContainerBackground(),
          GlassContainer(
            borderRadiusGeometry: BorderRadius.circular(0.0),
            sigmaX: AppSizes.size4,
            sigmaY: AppSizes.size4,
            height: context.height,
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  SettingsHeaderSection(),
                  SettingsSection(),
                  AppSizes.size16.height(),
                  CustomizeBackgroundSection()
                ]
              )
            )
          )
        ]
      )
    );
  }
}