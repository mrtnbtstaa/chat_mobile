part of 'theme_bloc.dart';

sealed class ThemeState extends Equatable {

  final AppTheme currentTheme;

  const ThemeState(this.currentTheme);
  
  @override
  List<Object> get props => [currentTheme];
}

final class ThemeInitial extends ThemeState {

  const ThemeInitial(super.currentTheme);
}
