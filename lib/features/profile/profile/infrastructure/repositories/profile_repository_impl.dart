import 'package:chat/core/contracts/i_user_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../../core/errors/failure.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/repositories/i_profile_repository.dart';
import '../../domain/value_objects/profile.dart';
import '../datasources/i_upload_remote_data_source.dart';
import '../dtos/request/upload_profile_request_dto.dart';

class ProfileRepositoryImpl implements IProfileRepository{

  final IUploadRemoteDataSource _uploadRemoteDataSource;
  final IUserStorage _userStorage;
  const ProfileRepositoryImpl(
    this._uploadRemoteDataSource,
    this._userStorage
  ); 

  @override
  Future<Either<Failure, ProfileEntity>> upload(Profile profile) async {

    if(kDebugMode){
      print("Path: ${profile.file.path}");
    }

    // Create a request DTO
    final requestDTO = UploadProfileRequestDto(image: profile.file.path); 

    // Call the datasource uploadProfile
    final result = await _uploadRemoteDataSource.uploadProfile(requestDTO);

    return await result.fold(
      (failure) => left(failure),
      (dto) async {
        await _userStorage.saveProfile(dto.profileUrl);
        return right(dto.toEntity());
      }
    );

  }
}