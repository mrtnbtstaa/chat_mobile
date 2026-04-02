import 'package:chat/core/style/app_colors.dart';
import 'package:chat/features/settings/application/bloc/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FontSlider extends StatelessWidget {
const FontSlider({ super.key });

  @override
  Widget build(BuildContext context){
    final settingBloc = context.watch<SettingsBloc>();
    return Slider(
      value: settingBloc.state.fontSizeSliderValue,
      onChanged: (val) => settingBloc.add(ThemeUpdateFontSize(fontScale: val)),
      onChangeEnd: (value) => settingBloc.add(ThemeSaveFontSizeToDisk(fontScale: value)),
      thumbColor: AppColors.primaryBrandColor,
      overlayColor: WidgetStateColor.resolveWith((_) => AppColors.lSurfaceLow),
      showValueIndicator: ShowValueIndicator.onDrag,
      activeColor: AppColors.lSurfaceMedium,
      inactiveColor: AppColors.lSurfaceMedium,
    );
  }
}