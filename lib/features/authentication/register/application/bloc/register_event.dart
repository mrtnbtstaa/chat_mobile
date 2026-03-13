part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

final class TogglePasswordVisibility extends RegisterEvent{}
final class ToggleConfirmPasswordVisibility extends RegisterEvent{}
final class RegisterCameraOpened extends RegisterEvent{} 
final class RegisterSubmitted extends RegisterEvent{

  final String username;
  final String password;
  final String confirmPassword;

  const RegisterSubmitted({
    required this.username,
    required this.password,
    required this.confirmPassword
  });

  @override
  List<Object> get props => [username, password, confirmPassword];
}
