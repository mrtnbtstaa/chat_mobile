import 'package:chat/core/errors/failure.dart';
import 'package:chat/features/profile/change_password/domain/params/password_param.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class IPasswordRepository {
  Future<Either<Failure, Unit>> changePassword(PasswordParam param);
}