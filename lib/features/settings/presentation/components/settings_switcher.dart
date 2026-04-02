import '../../../../core/style/app_colors.dart';
import 'setting_list_tile.dart';
import 'package:flutter/material.dart';

class SettingsSwitcher extends StatelessWidget {

  const SettingsSwitcher({ 
    super.key,
    required this.iconData,
    required this.text,
    required this.onTap,
    this.trailing
   });

  final IconData iconData;
  final String text;
  final VoidCallback onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context){
    return SettingListTile(
      iconData: iconData,
      text: text,
      onTap: onTap,
      withTrailing: true,
      trailing: Switch(
        value: true,
        onChanged: (value) {},
        thumbColor: WidgetStateColor.resolveWith((_) => AppColors.primaryBrandColor),
        trackColor: WidgetStateColor.resolveWith((_) => AppColors.primaryBrandColor.withValues(alpha: 0.1)),
      ),
    );
  }
}