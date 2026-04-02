import 'dart:async';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:chat/features/authentication/domain/enums/register_status.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/extensions/int_extension.dart';
import '../../../../../core/extensions/validator_builder_extension.dart';
part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {


  RegisterBloc() : super(RegisterState()) {
    on<TogglePasswordVisibility>((event, emit) => emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible)));
    on<ToggleConfirmPasswordVisibility>((event, emit) => emit(state.copyWith(isConfirmPasswordVisible: !state.isConfirmPasswordVisible)));
    on<RegisterSubmitted>(_registerSubmitted, transformer: droppable());
    on<OnFullNameChanged>(_onFullNameChanged);
    on<OnEmailChanged>(_onEmailChanged);
    on<OnPasswordChanged>(_onPasswordChanged);
    on<OnConfirmPasswordChanged>(_onConfirmPasswordChanged);
  }


  FutureOr<void> _registerSubmitted(RegisterSubmitted event, Emitter<RegisterState> emit) async {

    final fullNameError = event.fullName
      .validate("Full Name")
      .required()
      .validateFullName()
      .build();

    final emailError = event.email
      .validate("Email")
      .required()
      .isValidEmail()
      .build();

    final passwordError = event.password
      .validate("Password")
      .required()
      .minLength(8)
      .strongPassword()
      .build();

    final confirmPasswordError = event.confirmPassword
      .validate("Confirm Password")
      .required()
      .minLength(8)
      .strongPassword()
      .build();

    final hasError = fullNameError.isNotEmpty || passwordError.isNotEmpty || confirmPasswordError.isNotEmpty;
    
    if(hasError){
      emit(state.copyWith(
        registerStatus: RegisterStatus.error,
        fullNameError: () => fullNameError,
        emailError: () => emailError,
        passwordError: () => passwordError,
        confirmPasswordError: () => confirmPasswordError,
      ));
      return; // Exit early to not process the API
    }

    // If valid show the loading
    emit(state.copyWith(
      registerStatus: RegisterStatus.loading,
      errorMessage: ""
    ));

    try{

      await Future.delayed(3.seconds());
      // Api call

      // Emit register success 
      emit(state.copyWith(
        registerStatus: RegisterStatus.success,
      ));

    }catch(ex){
      emit(state.copyWith(
        errorMessage: ex.toString(),
        registerStatus: RegisterStatus.error,
      ));
    }

  }



  FutureOr<void> _onFullNameChanged(OnFullNameChanged event, Emitter<RegisterState> emit) {
      final error = event.fullName
      .validate("Full Name")
      .required()
      .validateFullName()
      .build();
      
      emit(state.copyWith(
        fullName: event.fullName,
        fullNameError: () => error,
      ));
  }

  FutureOr<void> _onPasswordChanged(OnPasswordChanged event, Emitter<RegisterState> emit) {

    final passwordError = event.password
    .validate("Password")
    .required()
    .minLength(8)
    .strongPassword()
    .build();


    String? confirmPasswordError = state.confirmPasswordError;

    if(state.confirmPassword.isNotEmpty){
      confirmPasswordError = state.confirmPassword
      .validate("Confirm Password")
      .passwordMatch(event.password)
      .build();
    }
    emit(state.copyWith(
      passwordError: () => passwordError,
      confirmPasswordError: () => confirmPasswordError,
      password: event.password
    ));
  }

  FutureOr<void> _onConfirmPasswordChanged(OnConfirmPasswordChanged event, Emitter<RegisterState> emit) {
    final confirmPasswordError = event.confirmPassword
    .validate("Confirm Password")
    .required()
    .minLength(8)
    .strongPassword()
    .build();

    emit(state.copyWith(confirmPasswordError: () => confirmPasswordError, confirmPassword: event.confirmPassword));
  }

  FutureOr<void> _onEmailChanged(OnEmailChanged event, Emitter<RegisterState> emit) {
    final emailError = event.email
    .validate("Email")
    .required()
    .isValidEmail()
    .build();

    emit(state.copyWith(email: event.email, emailError: () => emailError));
  }
}
