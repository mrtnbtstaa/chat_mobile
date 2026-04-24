import '../../../../../core/constants/api_constant.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/network/network_client.dart';
import 'i_upload_remote_data_source.dart';
import '../dtos/request/upload_profile_request_dto.dart';
import '../dtos/response/upload_profile_response_dto.dart';
import 'package:fpdart/fpdart.dart';

class UploadRemouteDataSourceImpl extends NetworkClient implements IUploadRemoteDataSource{

  UploadRemouteDataSourceImpl({super.client});

  @override
  Future<Either<Failure, UploadProfileResponseDto>> uploadProfile(UploadProfileRequestDto uploadProfileRequest) async =>
  patch<UploadProfileResponseDto>(
    ApiConstant.updateProfileApi,
    headers: {"Content-Type": "multipart/form-data"},
    onSuccess: (json) => UploadProfileResponseDto.fromJson(json),
    imagePath: uploadProfileRequest.image
  );
}