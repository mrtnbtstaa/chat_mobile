part of 'settings_bloc.dart';

sealed class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}


final class ThemeClicked extends SettingsEvent {

  final AppTheme appTheme;

  const ThemeClicked({this.appTheme = AppTheme.light});

  @override
  List<Object> get props => [appTheme];

}

final class ThemeUpdateFontSize extends SettingsEvent{
  
  final double fontScale;

  const ThemeUpdateFontSize({this.fontScale = 0.0});

  @override
  List<Object> get props => [fontScale];

}

final class ThemeSaveFontSizeToDisk extends SettingsEvent{
  final double fontScale;

  const ThemeSaveFontSizeToDisk({this.fontScale = 0.0});

  @override
  List<Object> get props => [fontScale];
}

final class ThemeChangedWallpaper extends SettingsEvent{
  final String selectedWallpaper;
  const ThemeChangedWallpaper({this.selectedWallpaper = ""});
  @override
  List<Object> get props => [selectedWallpaper];
}