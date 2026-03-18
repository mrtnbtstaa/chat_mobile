part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

final class OnUsernameChanged extends LoginEvent{
  final String username;
  const OnUsernameChanged({required this.username});
  @override
  List<Object> get props => [username];
}
final class OnPasswordChanged extends LoginEvent{
  final String password;
  const OnPasswordChanged({required this.password});
  @override
  List<Object> get props => [password];
}
final class TogglePasswordVisibility extends LoginEvent{}
final class LoginSubmitted extends LoginEvent{
  final String username;
  final String password;
  const LoginSubmitted({
    required this.username,
    required this.password
  });
  @override
  List<Object> get props => [username, password];
}
