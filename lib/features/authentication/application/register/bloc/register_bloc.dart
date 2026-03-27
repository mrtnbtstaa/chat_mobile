import 'dart:async';
import 'dart:developer';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:chat/features/authentication/domain/enums/register_status.dart';
import 'package:chat/features/authentication/infrastructure/services/media_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../core/extensions/int_extension.dart';
import '../../../../../core/extensions/validator_builder_extension.dart';
part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {

  final MediaService _mediaService; 

  RegisterBloc({required MediaService mediaService}) : _mediaService = mediaService,
    super(RegisterState()) {
    on<TogglePasswordVisibility>((event, emit) => emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible)));
    on<ToggleConfirmPasswordVisibility>((event, emit) => emit(state.copyWith(isConfirmPasswordVisible: !state.isConfirmPasswordVisible)));
    on<RegisterCameraOpened>(_registerCameraOpened);
    on<RegisterSubmitted>(_registerSubmitted, transformer: droppable());
    on<OnUsernameChanged>(_onUsernameChanged);
    on<OnPasswordChanged>(_onPasswordChanged);
    on<OnConfirmPasswordChanged>(_onConfirmPasswordChanged);
  }


  FutureOr<void> _registerSubmitted(RegisterSubmitted event, Emitter<RegisterState> emit) async {

    final usernameError = event.username
      .validate("Username")
      .required()
      .isAlphanumeric()
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

    final hasError = usernameError.isNotEmpty || passwordError.isNotEmpty || confirmPasswordError.isNotEmpty;
    
    if(hasError){
      emit(state.copyWith(
        registerStatus: RegisterStatus.error,
        usernameError: () => usernameError,
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

  FutureOr<void> _registerCameraOpened(RegisterCameraOpened event, Emitter<RegisterState> emit) async {
    try{
      final String? imagePath = await _mediaService.pickImage(ImageSource.gallery);
      if(imagePath != null){
        emit(state.copyWith(
          imagePath: imagePath,
        ));
      }
    }catch(ex){
      log(ex.toString());
      emit(state.copyWith(
        errorMessage: ex.toString(),
        registerStatus: RegisterStatus.error,
      ));
    }
  }

  FutureOr<void> _onUsernameChanged(OnUsernameChanged event, Emitter<RegisterState> emit) {
      final error = event.username
      .validate("Username")
      .required()
      .isAlphanumeric()
      .build();
      
      emit(state.copyWith(
        username: event.username,
        usernameError: () => error,
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
}
