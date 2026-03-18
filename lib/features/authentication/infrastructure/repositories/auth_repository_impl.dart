import 'package:chat/features/authentication/domain/entities/token_entity.dart';
import 'package:chat/features/authentication/infrastructure/datasources/local/i_local_auth_data_source.dart';
import 'package:chat/features/authentication/infrastructure/datasources/remote/i_remote_auth_data_source.dart';
import 'package:chat/features/authentication/infrastructure/dtos/request/access_token_request_dto.dart';
import 'package:chat/features/authentication/infrastructure/dtos/request/logout_request_dto.dart';
import 'package:chat/features/authentication/infrastructure/dtos/request/register_request_dto.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/entities/auth_entity.dart';
import '../../domain/repositories/i_auth_repository.dart';
import '../dtos/request/login_request_dto.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements IAuthRepository {

  final IRemoteAuthDataSource authRemoteDataSource;
  final ILocalAuthDataSource authLocalDataSource;

  const AuthRepositoryImpl({
    required this.authRemoteDataSource,
    required this.authLocalDataSource
  });

  @override
  Future<Either<Failure, AuthEntity>> login(String username, String password) async {

    // Create a request DTO
    final request = LoginRequestDto(username: username, password: password);

    // Call the datasource login and capture the result
    final result = await authRemoteDataSource.login(request.toJson());

    // Mapped the result to UserEntity()
    return result.fold(
      (failure) => left(failure),
      (dto) async {
        // Saved access and refresh token to flutter secure storage
        await authLocalDataSource.cacheToken(
          dto.tokens.accessToken,
          dto.tokens.refreshToken
        );
        return right(dto.toEntity());
      }
    );

  }
  
  @override
  Future<Either<Failure, Unit>> register(String username, String password, String confirmPassword, String? profile) async {
    // Create a request DTO
    final request = RegisterRequestDto(username: username, password: password, confirmPassword: confirmPassword, profile: profile);

    // Call the datasource register and capture the result
    final result = await authRemoteDataSource.register(request.toJson());

    return result.fold(
      (failure) => left(failure),
      (unit) => Right(unit)
    );
  }
  
  @override
  Future<Either<Failure, Unit>> logout(String refreshToken) async {
    // Create a request DTO
    final request = LogoutRequestDto(refreshToken: refreshToken);
    // Call the datasource logout and capture the result
    final result = await authRemoteDataSource.logout(request.toJson());
    return result.fold(
      (failure) => left(failure),
      (_) => right(unit)
    );
  }
  
  @override
  Future<Either<Failure, TokenEntity>> refreshToken(String refreshToken) async {
    // Create a request DTO
    final request = AccessTokenRequestDto(refreshToken);
     // Call the datasource refresh and capture the result
    final result = await authRemoteDataSource.refresh(request.toJson());
    return result.fold(
      (failure) => left(failure),
      (dto) => right(dto.toEntity())
    );
  }
  

}