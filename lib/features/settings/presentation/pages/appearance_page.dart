import '../../../../core/common_widgets/common_scaffold.dart';
import '../../../../core/extensions/double_extension.dart';
import '../../../../core/style/app_sizes.dart';
import '../components/sections/accessibility_font_selector_section.dart';
import '../components/sections/appbar_settings_section.dart';
import '../components/appearance/theme_section.dart';
import '../components/sections/wallpaper_selection_section.dart';
import 'package:flutter/material.dart';

class AppearancePage extends StatelessWidget {
const AppearancePage({ super.key });

  @override
  Widget build(BuildContext context){
    return CommonScaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AppbarSettingsSection(),
              ThemeSection(),
              AppSizes.size24.height(),
              AccessibilityFontSelectorSection(),
              WallpaperSelectionSection()
            ]
          ),
        )
      )
    );
  }
}