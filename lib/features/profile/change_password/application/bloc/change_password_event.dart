part of 'change_password_bloc.dart';

sealed class ChangePasswordEvent extends Equatable {

  const ChangePasswordEvent();

  @override
  List<Object> get props => [];
}

final class OnCurrentPasswordChanged extends ChangePasswordEvent{
  final String currentPassword;
  const OnCurrentPasswordChanged(this.currentPassword);
  @override
  List<Object> get props => [currentPassword];
}
final class OnNewPasswordChanged extends ChangePasswordEvent{
  final String newPassword;
  const OnNewPasswordChanged(this.newPassword);
  @override
  List<Object> get props => [newPassword];
}
final class OnConfirmPasswordChanged extends ChangePasswordEvent{
  final String confirmPassword;
  const OnConfirmPasswordChanged(this.confirmPassword);
  @override
  List<Object> get props => [confirmPassword];
}
final class PasswordSubmitted extends ChangePasswordEvent{

  final String currentPassword;
  final String newPassword;
  final String confirmPassword;

  const PasswordSubmitted({
    required this.currentPassword,
    required this.newPassword,
    required this.confirmPassword
  });

  @override
  List<Object> get props => [currentPassword, newPassword, confirmPassword];

}