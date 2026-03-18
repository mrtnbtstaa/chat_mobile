import 'package:chat/core/errors/failure.dart';
import 'package:chat/features/authentication/domain/entities/auth_entity.dart';
import 'package:chat/features/authentication/domain/entities/token_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class IAuthRepository {
  Future<Either<Failure, AuthEntity>> login(String username, String password);
  Future<Either<Failure, Unit>> register(String username, String password, String confirmPassword, String? profile);
  Future<Either<Failure, Unit>> logout(String refreshToken);
  Future<Either<Failure, TokenEntity>> refreshToken(String refreshToken);
}