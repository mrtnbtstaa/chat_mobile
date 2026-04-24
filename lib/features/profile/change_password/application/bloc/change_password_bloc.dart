import 'dart:async';

import 'package:chat/core/usecases/base_usecase.dart';
import 'package:chat/features/profile/change_password/domain/params/password_param.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../../core/extensions/validator_builder_extension.dart';
import '../../domain/enums/change_password_status.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc extends Bloc<ChangePasswordEvent, ChangePasswordState> {

  final BaseUsecase<Unit, PasswordParam> _changePasswordUsecase;

  ChangePasswordBloc({required BaseUsecase<Unit, PasswordParam> changePasswordUsecase}) :
    _changePasswordUsecase = changePasswordUsecase,
    super(ChangePasswordState()) {
    on<OnCurrentPasswordChanged>(_onCurrentPasswordChanged);
    on<OnNewPasswordChanged>(_onNewPasswordChanged);
    on<OnConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<PasswordSubmitted>(_onPasswordSubmitted);
  }

  FutureOr<void> _onCurrentPasswordChanged(OnCurrentPasswordChanged event, Emitter<ChangePasswordState> emit) {
    final currentPasswordError = event.currentPassword
    .validate("Current Password")
    .required()
    .build();

    emit(state.copyWith(
      currentPasswordError: () => currentPasswordError,
      currentPassword: event.currentPassword,
    ));
  }

  FutureOr<void> _onNewPasswordChanged(OnNewPasswordChanged event, Emitter<ChangePasswordState> emit) {
    
    final newPasswordError = event.newPassword
    .validate("New Password")
    .required()
    .minLength(8)
    .strongPassword()
    .build();

    String confirmPasswordError = state.confirmPasswordError;

    if(state.confirmPassword.isNotEmpty){
      confirmPasswordError = state.confirmPassword
      .validate("Confirm Password")
      .passwordMatch(event.newPassword)
      .build();
    }

    emit(state.copyWith(
      newPasswordError: () => newPasswordError,
      confirmPasswordError: () => confirmPasswordError,
      newPassword: event.newPassword,
    ));
  }

  FutureOr<void> _onConfirmPasswordChanged(OnConfirmPasswordChanged event, Emitter<ChangePasswordState> emit) {
    final confirmPassword = event.confirmPassword
    .validate("Confirm Password")
    .required()
    .minLength(8)
    .strongPassword()
    .build();

    emit(state.copyWith(
      confirmPasswordError: () => confirmPassword,
      confirmPassword: event.confirmPassword
    ));
  }

  FutureOr<void> _onPasswordSubmitted(PasswordSubmitted event, Emitter<ChangePasswordState> emit) async {

    final currentPasswordError = event.currentPassword
      .validate("Current Password")
      .required()
      .build();

    final newPasswordError = event.newPassword
      .validate("New Password")
      .required()
      .minLength(8)
      .strongPassword()
      .build();

    final confirmPasswordError = event.newPassword
      .validate("New Password")
      .required()
      .minLength(8)
      .strongPassword()
      .build();
    
    final hasError = currentPasswordError.isNotEmpty || newPasswordError.isNotEmpty || confirmPasswordError.isNotEmpty;

    if(hasError){
      if(kDebugMode){
        print("Has error!");
      }
      emit(state.copyWith(
        status: ChangePasswordStatus.error,
        currentPasswordError: () => currentPasswordError,
        newPasswordError: () => newPasswordError,
        confirmPasswordError: () => confirmPasswordError,
      ));
      return; // Early return
    }

    emit(state.copyWith(status: ChangePasswordStatus.loading));

    try{

      final usecase = await _changePasswordUsecase(
        PasswordParam(
          currentPassword: event.currentPassword,
          newPassword: event.newPassword,
          confirmPassword: event.confirmPassword
        )
      );

      usecase.fold(
        (failure){
          return emit(state.copyWith(status: ChangePasswordStatus.error, code: failure.code));
        },
        (_) => emit(state.copyWith(status: ChangePasswordStatus.success))
      );

    }catch(e){
      emit(state.copyWith(
        status: ChangePasswordStatus.error
      ));
    }

  }
}
