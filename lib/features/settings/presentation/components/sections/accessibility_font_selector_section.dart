import 'package:flutter/material.dart';
import '../../../../../core/common_widgets/common_container.dart';
import '../../../../../core/common_widgets/common_text.dart';
import '../../../../../core/extensions/context_extension.dart';
import '../../../../../core/extensions/double_extension.dart';
import '../../../../../core/style/app_insets.dart';
import '../../../../../core/style/app_sizes.dart';
import '../appearance/font_header.dart';
import '../appearance/font_slider.dart';

class AccessibilityFontSelectorSection extends StatelessWidget {
const AccessibilityFontSelectorSection({ super.key });

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: AppInsets.h32,
      child: CommonContainer(
        padding: AppInsets.a16,
        width: context.width,
        boxDecoration: BoxDecoration(
          color: context.currentTheme.cardTheme.color,
          borderRadius: BorderRadius.circular(AppSizes.size16)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FontHeader(),
            FontSlider(),
            AppSizes.size8.height(),
            CommonText(
              text: "Adjust the slider to scale font sizes across the application. This helps improve readability without breaking layout structure",
            )
          ]
        )
      )
    );
  }
}