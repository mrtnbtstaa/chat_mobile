import 'package:flutter/material.dart';

import '../../../../core/common_widgets/common_text.dart';
import '../../../../core/common_widgets/glass_container.dart';
import '../../../../core/style/app_insets.dart';
import '../../../../core/style/app_sizes.dart';

class SettingsHeaderSection extends StatelessWidget {
const SettingsHeaderSection({ super.key });

  @override
  Widget build(BuildContext context){
    return GlassContainer(
      borderRadiusGeometry: BorderRadius.circular(0.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: AppInsets.a16,
          child: CommonText(
            text: "Settings",
            fontWeight: FontWeight.bold,
            fontSize: AppSizes.font16,
          ),
        ),
      ),
    );
  }
}