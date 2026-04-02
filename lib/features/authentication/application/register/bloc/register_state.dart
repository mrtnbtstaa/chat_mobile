part of 'register_bloc.dart';



final class RegisterState extends Equatable {

  const RegisterState({
    this.isPasswordVisible = false,
    this.isConfirmPasswordVisible = false,
    this.registerStatus = RegisterStatus.initial,
    this.fullName = "",
    this.email = "",
    this.password = "",
    this.confirmPassword = "",
    this.errorMessage = "",
    this.fullNameError,
    this.emailError,
    this.passwordError,
    this.confirmPasswordError
  });

  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;
  final RegisterStatus registerStatus;
  final String fullName;
  final String email;
  final String password;
  final String confirmPassword;
  final String errorMessage;
  final String? fullNameError;
  final String? emailError;
  final String? passwordError;
  final String? confirmPasswordError;

  RegisterState copyWith({
    bool? isPasswordVisible,
    bool? isConfirmPasswordVisible,
    RegisterStatus? registerStatus,
    String? fullName,
    String? email,
    String? password,
    String? confirmPassword,
    String? errorMessage,
    ValueGetter<String?>? fullNameError,
    ValueGetter<String?>? emailError,
    ValueGetter<String?>? passwordError,
    ValueGetter<String?>? confirmPasswordError,
  }){
    return RegisterState(
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isConfirmPasswordVisible: isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
      registerStatus: registerStatus ?? this.registerStatus,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      errorMessage: errorMessage ?? this.errorMessage,
      fullNameError: fullNameError != null ? fullNameError() : this.fullNameError,
      emailError: emailError != null ? emailError() : this.emailError,
      passwordError: passwordError != null ? passwordError() : this.passwordError,
      confirmPasswordError: confirmPasswordError != null ? confirmPasswordError() : this.confirmPasswordError
    );
  }
  
  @override
  List<Object> get props => [isPasswordVisible, isConfirmPasswordVisible, registerStatus, fullName, password, confirmPassword, errorMessage, ?fullNameError, ?emailError, ?passwordError, ?confirmPasswordError];
}


