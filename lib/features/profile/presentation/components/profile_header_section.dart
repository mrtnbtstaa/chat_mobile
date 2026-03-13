import 'package:chat/core/constants/app_insets.dart';

import '../../../../core/common_widgets/common_text.dart';
import '../../../../core/common_widgets/glass_container.dart';
import '../../../../core/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class ProfileHeaderSection extends StatelessWidget {
const ProfileHeaderSection({ super.key });

  @override
  Widget build(BuildContext context){
    return GlassContainer(
      borderRadiusGeometry: BorderRadius.circular(0.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: AppInsets.a16,
          child: CommonText(
            text: "Profile",
            fontWeight: FontWeight.bold,
            fontSize: AppSizes.font16,
          ),
        ),
      ),
    );
  }
}