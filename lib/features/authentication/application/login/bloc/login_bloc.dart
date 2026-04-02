
import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:chat/core/services/session_manager.dart';
import 'package:flutter/foundation.dart';

import '../../../../../core/di/di.dart';
import '../../../../../core/usecases/base_usecase.dart';
import '../../../domain/entities/auth_entity.dart';
import '../../../domain/params/login_param.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/extensions/validator_builder_extension.dart';
import '../../../domain/enums/login_status.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  final BaseUsecase<AuthEntity, LoginParam> _loginUsecase;

  LoginBloc({required BaseUsecase<AuthEntity, LoginParam> loginUseCase}) : _loginUsecase = loginUseCase,
    super(LoginState()) {
    on<OnEmailChanged>(_onEmailChanged);
    on<OnPasswordChanged>(_onPasswordChanged);
    on<TogglePasswordVisibility>((event, emit) => emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible, loginStatus: LoginStatus.initial)));
    on<LoginSubmitted>(_loginSubmitted, transformer: droppable());
  }

  FutureOr<void> _onEmailChanged(OnEmailChanged event, Emitter<LoginState> emit) {
    final usernameError = event.email.
    validate("Email")
    .required()
    .build();

    emit(state.copyWith(email: event.email, emailError: () => usernameError, loginStatus: LoginStatus.initial));
  }

  FutureOr<void> _onPasswordChanged(OnPasswordChanged event, Emitter<LoginState> emit) {
    final passwordError = event.password
    .validate("Password")
    .required()
    .build();

    emit(state.copyWith(password: event.password, passwordError: () => passwordError, loginStatus: LoginStatus.initial));
  }

  FutureOr<void> _loginSubmitted(LoginSubmitted event, Emitter<LoginState> emit) async {

    if(kDebugMode){
      print("Login submitted triggered!");
    }

    final emailError = event.email.
    validate("Email")
    .required()
    .build();

    final passwordError = event.password
    .validate("Password")
    .required()
    .build();

    final hasError = emailError.isNotEmpty || passwordError.isNotEmpty;

    if(hasError){
      emit(
        state.copyWith(
          emailError: () => emailError,
          passwordError: () => passwordError,
          loginStatus: LoginStatus.initial
        )
      );
      return;
    }
    
    print("Never run!");

    emit(state.copyWith(
      loginStatus: LoginStatus.loading,
    ));

    // Execute the usecase
    final result = await _loginUsecase(LoginParam(email: event.email, password: event.password));

    return await result.fold(
      (failure) {
        if(kDebugMode){
          print("\x1B[32mCurrent code: ${failure.code}");
        }
        emit(state.copyWith(loginStatus: LoginStatus.error, code: failure.code));
      }, 
      (entity) {
        sl<SessionManager>().login();
        emit(state.copyWith(userEntity: entity, loginStatus: LoginStatus.success));
      }
    );

  }
}
