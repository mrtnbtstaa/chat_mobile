part of 'settings_bloc.dart';

sealed class SettingsState extends Equatable {

  final AppTheme appTheme;
  final double fontSizeSliderValue;
  final String selectedWallpaper;

  const SettingsState({
    this.appTheme = AppTheme.light,
    this.fontSizeSliderValue = 0.0,
    this.selectedWallpaper = ""
  });
  
  @override
  List<Object> get props => [appTheme, fontSizeSliderValue, selectedWallpaper];
}

final class ThemeSettings extends SettingsState{

  const ThemeSettings({super.appTheme, super.fontSizeSliderValue, selectedWallpaper});

}


