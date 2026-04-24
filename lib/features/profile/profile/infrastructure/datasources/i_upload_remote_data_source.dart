import '../../../../../core/errors/failure.dart';
import '../dtos/request/upload_profile_request_dto.dart';
import '../dtos/response/upload_profile_response_dto.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class IUploadRemoteDataSource {
  Future<Either<Failure, UploadProfileResponseDto>> uploadProfile(UploadProfileRequestDto uploadProfileRequest);
}