part of 'register_bloc.dart';



final class RegisterState extends Equatable {

  const RegisterState({
    this.isPasswordVisible = false,
    this.isConfirmPasswordVisible = false,
    this.registerStatus = RegisterStatus.initial,
    this.imagePath = "",
    this.username = "",
    this.password = "",
    this.confirmPassword = "",
    this.errorMessage = "",
    this.usernameError,
    this.passwordError,
    this.confirmPasswordError
  });

  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;
  final RegisterStatus registerStatus;
  final String imagePath;
  final String username;
  final String password;
  final String confirmPassword;
  final String errorMessage;
  final String? usernameError;
  final String? passwordError;
  final String? confirmPasswordError;

  RegisterState copyWith({
    bool? isPasswordVisible,
    bool? isConfirmPasswordVisible,
    RegisterStatus? registerStatus,
    String? imagePath,
    String? username,
    String? password,
    String? confirmPassword,
    String? errorMessage,
    ValueGetter<String?>? usernameError,
    ValueGetter<String?>? passwordError,
    ValueGetter<String?>? confirmPasswordError,
  }){
    return RegisterState(
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isConfirmPasswordVisible: isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
      registerStatus: registerStatus ?? this.registerStatus,
      imagePath: imagePath ?? this.imagePath,
      username: username ?? this.username,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      errorMessage: errorMessage ?? this.errorMessage,
      usernameError: usernameError != null ? usernameError() : this.usernameError,
      passwordError: passwordError != null ? passwordError() : this.passwordError,
      confirmPasswordError: confirmPasswordError != null ? confirmPasswordError() : this.confirmPasswordError
    );
  }
  
  @override
  List<Object> get props => [isPasswordVisible, isConfirmPasswordVisible, registerStatus, imagePath, username, password, confirmPassword, errorMessage, ?usernameError, ?passwordError, ?confirmPasswordError];
}


