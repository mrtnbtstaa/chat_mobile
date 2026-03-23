import 'package:chat/core/contracts/i_token_storage.dart';
import 'package:chat/core/contracts/i_user_storage.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/entities/auth_entity.dart';
import '../../domain/entities/token_entity.dart';
import '../../domain/repositories/i_auth_repository.dart';
import '../datasources/remote/i_remote_auth_data_source.dart';
import '../dtos/request/login_request_dto.dart';
import '../dtos/request/logout_request_dto.dart';
import '../dtos/request/refresh_token_request_dto.dart';
import '../dtos/request/register_request_dto.dart';
import '../dtos/request/verify_token_request_dto.dart';

class AuthRepositoryImpl implements IAuthRepository {

  final IRemoteAuthDataSource _authRemoteDataSource;
  final ITokenStorage _tokenStorage;
  final IUserStorage _userStorage;

  const AuthRepositoryImpl(
    this._authRemoteDataSource,
    this._tokenStorage,
    this._userStorage
  );

  @override
  Future<Either<Failure, AuthEntity>> login(String username, String password) async {

    // Create a request DTO
    final request = LoginRequestDto(username: username, password: password);

    // Call the datasource login and capture the result
    final result = await _authRemoteDataSource.login(request);

    return await result.fold(
      (failure) async => left(failure),
      (dto) async {
        // Saved access and refresh token to flutter secure storage
        await _tokenStorage.cacheToken(
          dto.tokens.accessToken,
          dto.tokens.refreshToken
        );

        await _userStorage.saveUserId(dto.userId);
        return right(dto.toEntity());
      }
    );

  }
  
  @override
  Future<Either<Failure, Unit>> register(String username, String password, String confirmPassword, String? profile) async {
    // Create a request DTO
    final request = RegisterRequestDto(username: username, password: password, confirmPassword: confirmPassword, profile: profile);

    // Call the datasource register and capture the result
    final result = await _authRemoteDataSource.register(request.toJson());

    return await result.fold(
      (failure) async => left(failure),
      (unit) => Right(unit)
    );
  }
  
  @override
  Future<Either<Failure, Unit>> logout(String refreshToken) async {
    // Create a request DTO
    final request = LogoutRequestDto(refreshToken: refreshToken);
    // Call the datasource logout and capture the result
    final result = await _authRemoteDataSource.logout(request);
    return await result.fold(
      (failure) async => left(failure),
      (_) async => right(unit)
    );
  }
  
  @override
  Future<Either<Failure, TokenEntity>> refreshToken(String refreshToken) async {

    // Create a request DTO
    final request = RefreshTokenRequestDto(refreshToken);

    // Call the datasource refresh and capture the result
    final result = await _authRemoteDataSource.refresh(request);
    return await result.fold(
      (failure) => left(failure),
      (dto) => right(dto.toEntity())
    );
  }
  
  @override
  Future<Either<Failure, Unit>> verifyToken(String accessToken) async {
    
    // Create a request DTO
    final request = VerifyTokenRequestDto(accessToken: accessToken);

    // Call the datasource verify and capture the result
    final result = await _authRemoteDataSource.verify(request);

    return await result.fold(
      (failure) => left(failure), 
      (_) => right(unit)
    );

  }
  

}