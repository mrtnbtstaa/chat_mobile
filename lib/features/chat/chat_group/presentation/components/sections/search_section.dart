import '../../../../../../core/common_widgets/common_icon.dart';
import '../../../../../../core/common_widgets/common_text_field.dart';
import '../../../../../../core/extensions/context_extension.dart';
import '../../../../../../core/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class SearchSection extends StatelessWidget {
const SearchSection({ super.key });

  @override
  Widget build(BuildContext context){
    return CommonTextField(
      hintText: "Search contacts",
      onChanged: (v) => {},
      controller: TextEditingController(),
      prefixIconWidget: CommonIcon(
        iconData: IonIcons.search,
        iconColor: context.isDarkMode ? AppColors.dTextSecondary : AppColors.ltextSecondary,
      ),
    );
  }
}