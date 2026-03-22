import 'package:chat/features/authentication/infrastructure/dtos/request/verify_token_request_dto.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/entities/auth_entity.dart';
import '../../domain/entities/token_entity.dart';
import '../../domain/repositories/i_auth_repository.dart';
import '../datasources/local/i_local_auth_data_source.dart';
import '../datasources/remote/i_remote_auth_data_source.dart';
import '../dtos/request/refresh_token_request_dto.dart';
import '../dtos/request/login_request_dto.dart';
import '../dtos/request/logout_request_dto.dart';
import '../dtos/request/register_request_dto.dart';

class AuthRepositoryImpl implements IAuthRepository {

  final IRemoteAuthDataSource authRemoteDataSource;
  final ILocalAuthDataSource authLocalDataSource;

  const AuthRepositoryImpl({
    required this.authRemoteDataSource,
    required this.authLocalDataSource,
  });

  @override
  Future<Either<Failure, AuthEntity>> login(String username, String password) async {

    // Create a request DTO
    final request = LoginRequestDto(username: username, password: password);

    // Call the datasource login and capture the result
    final result = await authRemoteDataSource.login(request);

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
      (failure){
        return left(failure);
      },
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
      (failure) async {
        await authLocalDataSource.clearTokens();
        return left(failure);
      },
      (_) async {
        await authLocalDataSource.clearTokens();
        return right(unit);
      }
    );
  }
  
  @override
  Future<Either<Failure, TokenEntity>> refreshToken(String refreshToken) async {

    // Create a request DTO
    final request = RefreshTokenRequestDto(refreshToken);

    // Call the datasource refresh and capture the result
    final result = await authRemoteDataSource.refresh(request);
    return result.fold(
      (failure) => left(failure),
      (dto) => right(dto.toEntity())
    );
  }
  
  @override
  Future<Either<Failure, Unit>> verifyToken(String accessToken) async {
    
    // Create a request DTO
    final request = VerifyTokenRequestDto(accessToken: accessToken);

    // Call the datasource verify and capture the result
    final result = await authRemoteDataSource.verify(request);

    return result.fold(
      (failure) => left(failure), 
      (_) => right(unit)
    );

  }
  

}