import 'dart:async';
import 'dart:io';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import '../../../../../core/di/di_exports.dart';
import '../../domain/value_objects/profile.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final MediaService _mediaService;
  final BaseUsecase<ProfileEntity, ProfileParam> _uploadUseCase;
  ProfileBloc({
    required MediaService mediaService,
    required BaseUsecase<ProfileEntity, ProfileParam> uploadUsecase
  }) : _mediaService = mediaService, _uploadUseCase = uploadUsecase,
  super(ProfileInitial()) {
    on<UploadProfile>(_onUploadProfile);
  }

  FutureOr<void> _onUploadProfile(UploadProfile event, Emitter<ProfileState> emit) async {

    final path = await _mediaService.pickImage(ImageSource.gallery);

    if(path?.isNotEmpty ?? false){
      emit(ProfileUploaded(imagePath: path));
    }else{
      return;
    }

    final createProfile = await Profile.create(
      file: File(path ?? ""),
      maxMb: 2.0,
      allowedExtensions: ['jpeg', 'png', 'jpg']
    );

    await createProfile.fold(
      (profileFailure) async{
        print("${profileFailure.message}, ${profileFailure.error}");
        emit(ProfileError(error: profileFailure.message));
      },
      (profile) async{
        
        final uploadUseCase = await _uploadUseCase(ProfileParam(profile: profile));

        uploadUseCase.fold(
          (failure) => emit(ProfileError()),
          (entity) => emit(ProfileSuccess(imageUrl: entity.profileUrl))
        );

      } 
    );

  }
}
