part of 'login_bloc.dart';

class LoginState extends Equatable {

  const LoginState({
    this.emailError,
    this.passwordError,
    this.email = "",
    this.password = "",
    this.loginStatus = LoginStatus.initial,
    this.isPasswordVisible = false,
    this.userEntity,
    this.code
  });

  final String email;
  final String password;
  final String? emailError;
  final String? passwordError;
  final LoginStatus loginStatus;
  final bool isPasswordVisible;
  final AuthEntity? userEntity;
  final String? code;

  LoginState copyWith({
    final String? email,
    final String? password,
    ValueGetter<String?>? emailError,
    ValueGetter<String?>? passwordError,
    final LoginStatus? loginStatus,
    final bool? isPasswordVisible,
    final AuthEntity? userEntity,
    final String? code
  }){
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      emailError: emailError != null ? emailError() : this.emailError,
      passwordError: passwordError != null ? passwordError() : this.passwordError,
      loginStatus: loginStatus ?? this.loginStatus,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      userEntity: userEntity,
      code: code ?? this.code
    );
  }
  
  @override
  List<Object> get props => [email, password, ?emailError, ?passwordError, loginStatus, isPasswordVisible, ?userEntity, ?code];
}

