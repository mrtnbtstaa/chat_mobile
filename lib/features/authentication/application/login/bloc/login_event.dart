part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

final class OnEmailChanged extends LoginEvent{
  final String email;
  const OnEmailChanged({required this.email});
  @override
  List<Object> get props => [email];
}
final class OnPasswordChanged extends LoginEvent{
  final String password;
  const OnPasswordChanged({required this.password});
  @override
  List<Object> get props => [password];
}
final class TogglePasswordVisibility extends LoginEvent{}
final class LoginSubmitted extends LoginEvent{
  final String email;
  final String password;
  const LoginSubmitted({
    required this.email,
    required this.password
  });
  @override
  List<Object> get props => [email, password];
}
