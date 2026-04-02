import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:chat/core/common/core_transformers.dart';
import 'package:chat/core/enum/app_theme.dart';
import 'package:chat/core/extensions/int_extension.dart';
import 'package:chat/core/utils/settings_manager.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(ThemeSettings(
    appTheme: SettingsManager().getTheme,
    fontSizeSliderValue: SettingsManager().getTextScale,
    selectedWallpaper: SettingsManager().getWallpaper
  )) {
    on<ThemeClicked>((event, emit) async {
      await SettingsManager().setTheme(event.appTheme);
      emit(ThemeSettings(appTheme: event.appTheme));
    });
    on<ThemeUpdateFontSize>((event, emit) => emit(ThemeSettings(appTheme: state.appTheme, fontSizeSliderValue: event.fontScale)));
    on<ThemeSaveFontSizeToDisk>((event, emit) async {
      await SettingsManager().setTextScale(event.fontScale);
      emit(ThemeSettings(appTheme: state.appTheme, fontSizeSliderValue: event.fontScale));
    });
    on<ThemeChangedWallpaper>((event, emit) {
      
    });
  }
}
