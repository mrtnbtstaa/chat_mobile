part of 'login_bloc.dart';

class LoginState extends Equatable {

  const LoginState({
    this.usernameError,
    this.passwordError,
    this.username = "",
    this.password = "",
    this.loginStatus = LoginStatus.initial,
    this.isPasswordVisible = false,
    this.userEntity,
    this.code
  });

  final String username;
  final String password;
  final String? usernameError;
  final String? passwordError;
  final LoginStatus loginStatus;
  final bool isPasswordVisible;
  final AuthEntity? userEntity;
  final String? code;

  LoginState copyWith({
    final String? username,
    final String? password,
    ValueGetter<String?>? usernameError,
    ValueGetter<String?>? passwordError,
    final LoginStatus? loginStatus,
    final bool? isPasswordVisible,
    final AuthEntity? userEntity,
    final String? code
  }){
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      usernameError: usernameError != null ? usernameError() : this.usernameError,
      passwordError: passwordError != null ? passwordError() : this.passwordError,
      loginStatus: loginStatus ?? this.loginStatus,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      userEntity: userEntity,
      code: code ?? this.code
    );
  }
  
  @override
  List<Object> get props => [username, password, ?usernameError, ?passwordError, loginStatus, isPasswordVisible, ?userEntity, ?code];
}

