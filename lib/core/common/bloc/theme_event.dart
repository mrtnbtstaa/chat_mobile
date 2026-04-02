part of 'theme_bloc.dart';

sealed class ThemeEvent extends Equatable {

  final AppTheme currentTheme;

  const ThemeEvent({this.currentTheme = AppTheme.light});

  @override
  List<Object> get props => [currentTheme];
}

final class ThemeChanged extends ThemeEvent {

  const ThemeChanged({super.currentTheme});

}