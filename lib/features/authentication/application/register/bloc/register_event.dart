part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

final class TogglePasswordVisibility extends RegisterEvent{}
final class ToggleConfirmPasswordVisibility extends RegisterEvent{}
final class RegisterSubmitted extends RegisterEvent{

  final String fullName;
  final String email;
  final String password;
  final String confirmPassword;

  const RegisterSubmitted({
    required this.fullName,
    required this.email,
    required this.password,
    required this.confirmPassword
  });

  @override
  List<Object> get props => [fullName, email, password, confirmPassword];
}
final class OnFullNameChanged extends RegisterEvent{
  final String fullName;
  const OnFullNameChanged({required this.fullName});
  @override
  List<Object> get props => [fullName];
}
final class OnEmailChanged extends RegisterEvent{
  final String email;
  const OnEmailChanged({required this.email});
  @override
  List<Object> get props => [email];
}
final class OnPasswordChanged extends RegisterEvent{
  final String password;
  const OnPasswordChanged({required this.password});
  @override
  List<Object> get props => [password];
}
final class OnConfirmPasswordChanged extends RegisterEvent{
  final String confirmPassword;
  const OnConfirmPasswordChanged({required this.confirmPassword});
  @override
  List<Object> get props => [confirmPassword];
}