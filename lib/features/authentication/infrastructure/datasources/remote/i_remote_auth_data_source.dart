import 'package:chat/core/errors/failure.dart';
import 'package:chat/features/authentication/infrastructure/dtos/response/login_response_dto.dart';
import 'package:chat/features/authentication/infrastructure/dtos/token_dto.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class IRemoteAuthDataSource {
  Future<Either<Failure, LoginResponseDto>> login(Map<String, dynamic> data);
  Future<Either<Failure, Unit>> register(Map<String, dynamic> data);
  Future<Either<Failure, Unit>> logout(Map<String, dynamic> data);
  Future<Either<Failure, TokenDto>> refresh(Map<String, dynamic> data);
}