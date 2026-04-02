import 'dart:async';
import 'package:chat/core/enum/app_theme.dart';
import 'package:chat/core/utils/settings_manager.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeInitial(SettingsManager().getTheme)) {
    on<ThemeChanged>(_onThemeChanged);
  }

  FutureOr<void> _onThemeChanged(ThemeChanged event, Emitter<ThemeState> emit) async {
    if(kDebugMode){
      print("EVENT FIRED!");
    }
    await SettingsManager().setTheme(event.currentTheme);
    emit(ThemeInitial(event.currentTheme));
  }
}
