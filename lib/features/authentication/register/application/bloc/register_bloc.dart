import 'dart:async';
import 'dart:developer';

import 'package:chat/core/extensions/int_extension.dart';
import 'package:chat/features/authentication/register/infrastructure/services/media_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final MediaService _mediaService; 

  RegisterBloc({required MediaService mediaService}) : 
    _mediaService = mediaService, super(RegisterInitial()) {
    on<TogglePasswordVisibility>((event, emit) => emit(RegisterInitial(isPasswordVisible: !state.isPasswordVisible, isConfirmPasswordVisible: state.isConfirmPasswordVisible)));
    on<ToggleConfirmPasswordVisibility>((event, emit) => emit(RegisterInitial(isPasswordVisible: state.isPasswordVisible, isConfirmPasswordVisible: !state.isConfirmPasswordVisible)));
    on<RegisterCameraOpened>(_registerCameraOpened);
    on<RegisterSubmitted>(_registerSubmitted);
  }

  FutureOr<void> _registerSubmitted(RegisterSubmitted event, Emitter<RegisterState> emit) async {

    emit(RegisterLoading(
      isPasswordVisible: state.isPasswordVisible,
      isConfirmPasswordVisible: state.isConfirmPasswordVisible
    ));

    await Future.delayed(3.seconds());

    try{

      // Api call

      // Emit register success 
      emit(RegisterSuccess(
        isPasswordVisible: state.isPasswordVisible,
        isConfirmPasswordVisible: state.isConfirmPasswordVisible
      ));

    }catch(ex){
      emit(RegisterError(
        errorMessage: ex.toString(),
        isPasswordVisible: state.isPasswordVisible,
        isConfirmPasswordVisible: state.isConfirmPasswordVisible
      ));
    }

  }

  FutureOr<void> _registerCameraOpened(RegisterCameraOpened event, Emitter<RegisterState> emit) async {
    try{
      final String? imagePath = await _mediaService.pickImage(ImageSource.gallery);
      if(imagePath != null){
        emit(RegisterPickedImage(isPasswordVisible: state.isPasswordVisible, isConfirmPasswordVisible: state.isConfirmPasswordVisible, imagePath: imagePath));
      }
    }catch(ex){
      log(ex.toString());
      emit(RegisterError(errorMessage: ex.toString()));
    }
  }
}
