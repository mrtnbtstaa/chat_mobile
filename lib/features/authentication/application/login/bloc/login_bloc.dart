
import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:chat/core/services/session_manager.dart';
import 'package:chat/features/authentication/domain/value_objects/email.dart';
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
    final emailError = event.email.
    validate("Email")
    .required()
    .isValidEmail()
    .build();

    emit(state.copyWith(email: event.email, emailError: () => emailError, loginStatus: LoginStatus.initial));
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
    
    emit(state.copyWith(
      loginStatus: LoginStatus.loading,
    ));

    final emailResult = Email.create(event.email);

    await emailResult.fold(
      (emailFailure) async {
        if(kDebugMode){
          print("Email: ${emailFailure.message}");
        }
        emit(state.copyWith(
          loginStatus: LoginStatus.error,
        ));
      }, 
      (validEmail) async {

        // Execute the login usecase
        final result = await _loginUsecase(LoginParam(
          email: validEmail,
          password: event.password
        ));

        result.fold(
          (failure) => emit(state.copyWith(loginStatus: LoginStatus.error, code: failure.code)),
          (entity) {
            sl<SessionManager>().login();
            emit(state.copyWith(userEntity: entity, loginStatus: LoginStatus.success));
          }
        );
      }
    );
  }
}
