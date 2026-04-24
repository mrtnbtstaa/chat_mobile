import 'package:fpdart/fpdart.dart';
import '../../../../../core/constants/api_constant.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/network/network_client.dart';
import '../dtos/password_request_dto.dart';
import 'i_password_remote_data_source.dart';

class PasswordRemoteDataSource extends NetworkClient implements IPasswordRemoteDataSource{

  PasswordRemoteDataSource({super.client});

  @override
  Future<Either<Failure, Unit>> changePassword(PasswordRequestDto passwordDTO) async => 
  await patch(
    ApiConstant.changePasswordApi,
    onSuccess: (_) => unit,
    body: passwordDTO.toJson()
  );
}