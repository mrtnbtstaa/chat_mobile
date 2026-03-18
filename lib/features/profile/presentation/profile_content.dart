import 'package:flutter/material.dart';

import '../../../core/extensions/double_extension.dart';
import 'components/user_status_section.dart';
import 'components/profile_header_section.dart';
import 'components/profile_section.dart';
import '../../../core/common_widgets/common_container_background.dart';
import '../../../core/common_widgets/common_scaffold.dart';
import '../../../core/common_widgets/glass_container.dart';
import '../../../core/style/app_sizes.dart';
import '../../../core/extensions/context_extension.dart';

class ProfileContent extends StatelessWidget {
const ProfileContent({ super.key });

  @override
  Widget build(BuildContext context){
    return CommonScaffold(
      body: Stack(
        fit: StackFit.expand,
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
                  ProfileHeaderSection(),
                  AppSizes.size32.height(),
                  ProfileSection(),
                  AppSizes.size8.height(),
                  UserStatusSection()
                ]
              )
            )
          )
        ]
      )
    );
  }
}