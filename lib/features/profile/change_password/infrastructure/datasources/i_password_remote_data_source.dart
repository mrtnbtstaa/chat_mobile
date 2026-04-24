import 'package:fpdart/fpdart.dart';

import '../../../../../core/errors/failure.dart';
import '../dtos/password_request_dto.dart';

abstract interface class IPasswordRemoteDataSource {
  Future<Either<Failure, Unit>> changePassword(PasswordRequestDto passwordDTO);
}