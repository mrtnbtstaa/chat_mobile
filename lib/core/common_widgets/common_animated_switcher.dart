import 'package:chat/core/style/app_colors.dart';
import 'package:flutter/material.dart';

class CommonAnimatedSwitcher extends AnimatedSwitcher{

  final bool value;
  final Function(bool)? onChanged;

  CommonAnimatedSwitcher({
    super.key,
    required super.duration,
    required this.value,
    required this.onChanged
  }) : super(
    child: Switch(
      value: value,
      onChanged: onChanged,
      thumbColor: WidgetStateColor.resolveWith((_) => AppColors.lSurfaceMedium),
      activeThumbColor: AppColors.lSurfaceMedium,
      activeTrackColor: AppColors.primaryBrandColor,
      inactiveThumbColor: AppColors.lSurfaceMedium,
      trackOutlineColor: WidgetStateColor.resolveWith((_) => Colors.transparent),
    )
  );

}