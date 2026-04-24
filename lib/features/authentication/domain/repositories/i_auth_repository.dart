import 'package:chat/features/authentication/domain/value_objects/email.dart';

import '../../../../core/errors/failure.dart';
import '../entities/auth_entity.dart';
import '../entities/token_entity.dart';

import 'package:fpdart/fpdart.dart';

abstract interface class IAuthRepository {
  Future<Either<Failure, AuthEntity>> login(Email email, String password);
  Future<Either<Failure, Unit>> register(String username, String password, String confirmPassword, String? profile);
  Future<Either<Failure, Unit>> logout(String refreshToken);
  Future<Either<Failure, TokenEntity>> refreshToken(String refreshToken);
  Future<Either<Failure, Unit>> verifyToken(String accessToken);
}