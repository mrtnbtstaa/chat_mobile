import 'package:flutter/material.dart';
import '../../../../core/common_widgets/common_list_tile.dart';
import '../../../../core/common_widgets/glass_container.dart';
import '../../../../core/constants/app_insets.dart';

class SettingListTile extends StatelessWidget {

  const SettingListTile({ 
    super.key,
    required this.iconData,
    required this.text,
    required this.onTap,
    this.withTrailing = false,
    this.trailing
   });

  final IconData iconData;
  final String text;
  final VoidCallback onTap;
  final bool withTrailing;
  final Widget? trailing;

  @override
  Widget build(BuildContext context){

    if(withTrailing){
      return GlassContainer(
        margin: AppInsets.h16,
        child: CommonListTile(
          withTrailing: withTrailing,
          iconData: iconData,
          text: text,
          onTap: onTap,
          trailing: trailing,
        ),
      );
    }

    return GlassContainer(
      margin: AppInsets.a16,
      child: CommonListTile(
        iconData: iconData,
        text: text,
        onTap: onTap,
      ),
    );
  }
}