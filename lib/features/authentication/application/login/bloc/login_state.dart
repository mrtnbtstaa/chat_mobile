part of 'login_bloc.dart';

class LoginState extends Equatable {

  const LoginState({
    this.usernameError,
    this.passwordError,
    this.errorMessage,
    this.username = "",
    this.password = "",
    this.loginStatus = LoginStatus.initial,
    this.isPasswordVisible = false,
    this.userEntity
  });

  final String username;
  final String password;
  final String? usernameError;
  final String? passwordError;
  final String? errorMessage;
  final LoginStatus loginStatus;
  final bool isPasswordVisible;
  final AuthEntity? userEntity;

  LoginState copyWith({
    final String? username,
    final String? password,
    ValueGetter<String?>? usernameError,
    ValueGetter<String?>? passwordError,
    final String? errorMessage,
    final LoginStatus? loginStatus,
    final bool? isPasswordVisible,
    final AuthEntity? userEntity
  }){
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      usernameError: usernameError != null ? usernameError() : this.usernameError,
      passwordError: passwordError != null ? passwordError() : this.passwordError,
      errorMessage: errorMessage ?? this.errorMessage,
      loginStatus: loginStatus ?? this.loginStatus,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      userEntity: userEntity ?? this.userEntity
    );
  }
  
  @override
  List<Object> get props => [username, password, ?usernameError, ?passwordError, ?errorMessage, loginStatus, isPasswordVisible, ?userEntity];
}

