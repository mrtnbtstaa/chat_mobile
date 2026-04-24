import 'dart:async';
import 'package:chat/core/enum/app_theme.dart';
import 'package:chat/core/utils/settings_manager.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(ThemeSettings(   
    appTheme: SettingsManager().getTheme,
    fontSizeSliderValue: SettingsManager().getTextScale,
    selectedWallpaper: SettingsManager().getWallpaper
  )) {
    on<ThemeClicked>(_onThemeClicked);
    on<ThemeUpdateFontSize>(_onThemeUpdateFontSize);
    on<ThemeSaveFontSizeToDisk>(_onThemeSaveFontSizeToDisk);
  }

  FutureOr<void> _onThemeClicked(ThemeClicked event, Emitter<SettingsState> emit) async {
    await SettingsManager().setTheme(event.appTheme);
    emit(ThemeSettings(appTheme: event.appTheme, fontSizeSliderValue: state.fontSizeSliderValue));
  }
  FutureOr<void> _onThemeUpdateFontSize(ThemeUpdateFontSize event, Emitter<SettingsState> emit){
    emit(ThemeSettings(appTheme: state.appTheme, fontSizeSliderValue: event.fontScale));
  }
  FutureOr<void> _onThemeSaveFontSizeToDisk(ThemeSaveFontSizeToDisk event, Emitter<SettingsState> emit) async {
     await SettingsManager().setTextScale(event.fontScale);
    emit(ThemeSettings(appTheme: state.appTheme, fontSizeSliderValue: event.fontScale));
  }
}
