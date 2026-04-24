import 'package:chat/features/authentication/infrastructure/dtos/request/logout_request_dto.dart';
import 'package:chat/features/authentication/infrastructure/dtos/request/verify_token_request_dto.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../../core/constants/api_constant.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/network/network_client.dart';
import '../../dtos/request/refresh_token_request_dto.dart';
import '../../dtos/request/login_request_dto.dart';
import '../../dtos/response/login_response_dto.dart';
import '../../dtos/response/refresh_token_response_dto.dart';
import 'i_remote_auth_data_source.dart';

class AuthRemoteDataSourceImpl extends NetworkClient implements IRemoteAuthDataSource {
  
  AuthRemoteDataSourceImpl({super.client});

  @override
  Future<Either<Failure, LoginResponseDto>> login(LoginRequestDto loginRequestDto) async =>
  await post<LoginResponseDto>(
    ApiConstant.loginApi,
    body: loginRequestDto.toJson(),
    onSuccess: (json) {
        if(kDebugMode){
          print("Json: $json and fromJson: ${LoginResponseDto.fromJson(json)}");
        }
      return LoginResponseDto.fromJson(json);
    }
  );
  
  @override
  Future<Either<Failure, Unit>> register(Map<String, dynamic> data) async =>
  await post<Unit>(
    ApiConstant.registerApi,
    body: data,
    onSuccess: (_) => unit,
    statusCode: 201
  );
  
  @override
  Future<Either<Failure, Unit>> logout(LogoutRequestDto logoutRequestDto) async =>
  await post<Unit>(
    ApiConstant.logoutApi,
    body: logoutRequestDto.toJson(),
    onSuccess: (_) => unit,
    statusCode: 205
  );
  
  @override
  Future<Either<Failure, RefreshTokenResponseDto>> refresh(RefreshTokenRequestDto refreshTokenDto) async =>
  await post<RefreshTokenResponseDto>(
    ApiConstant.refreshApi,
    body: refreshTokenDto.toJson(),
    onSuccess: (json) => RefreshTokenResponseDto.fromJson(json)
  );

  @override
  Future<Either<Failure, Unit>> verify(VerifyTokenRequestDto verifyTokenDto) async =>
  await post<Unit>(
    ApiConstant.verifyTokenApi,
    body: verifyTokenDto.toJson(),
    onSuccess: (_) => unit
  );

}