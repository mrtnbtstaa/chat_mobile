part of 'change_password_bloc.dart';

final class ChangePasswordState extends Equatable {

  final String currentPasswordError;
  final String newPasswordError;
  final String confirmPasswordError;
  final String currentPassword;
  final String newPassword;
  final String confirmPassword;
  final String code;
  final ChangePasswordStatus status;

  const ChangePasswordState({
    this.currentPasswordError = "",
    this.newPasswordError = "",
    this.confirmPasswordError = "",
    this.currentPassword = "",
    this.newPassword = "",
    this.confirmPassword = "",
    this.code = "",
    this.status = ChangePasswordStatus.initial
  });

  ChangePasswordState copyWith({
    ValueGetter<String>? currentPasswordError,
    ValueGetter<String>? newPasswordError,
    ValueGetter<String>? confirmPasswordError,
    String? currentPassword,
    String? newPassword,
    String? confirmPassword,
    String? code,
    ChangePasswordStatus? status
  }){
    return ChangePasswordState(
      currentPasswordError: currentPasswordError != null ? currentPasswordError() : this.currentPasswordError,
      newPasswordError: newPasswordError != null ? newPasswordError() : this.newPasswordError,
      confirmPasswordError: confirmPasswordError != null ? confirmPasswordError() : this.confirmPasswordError,
      currentPassword: currentPassword ?? this.currentPassword,
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      code: code ?? this.code,
      status: status ?? this.status
    );
  }
  
  @override
  List<Object> get props => [currentPasswordError, newPasswordError, confirmPasswordError, currentPassword, newPassword, confirmPassword, code, status];
}


