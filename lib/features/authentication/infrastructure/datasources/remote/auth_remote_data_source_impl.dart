import 'package:chat/features/authentication/infrastructure/datasources/remote/i_remote_auth_data_source.dart';
import 'package:chat/features/authentication/infrastructure/dtos/token_dto.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../../core/constants/api_constant.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/network/network_client.dart';
import '../../dtos/response/login_response_dto.dart';

class AuthRemoteDataSourceImpl extends NetworkClient implements IRemoteAuthDataSource {

  AuthRemoteDataSourceImpl({super.client});

  @override
  Future<Either<Failure, LoginResponseDto>> login(Map<String, dynamic> data) async =>
  await post<LoginResponseDto>(
    ApiConstant.login,
    body: data,
    onSuccess: (json) => LoginResponseDto.fromJson(json)
  );
  
  @override
  Future<Either<Failure, Unit>> register(Map<String, dynamic> data) async =>
  await post<Unit>(
    ApiConstant.register,
    body: data,
    onSuccess: (_) => unit,
    statusCode: 201
  );
  
  @override
  Future<Either<Failure, Unit>> logout(Map<String, dynamic> data) async =>
  await post<Unit>(
    ApiConstant.logout,
    body: data,
    onSuccess: (_) => unit
  );
  
  @override
  Future<Either<Failure, TokenDto>> refresh(Map<String, dynamic> data) async =>
  await post<TokenDto>(
    ApiConstant.refresh,
    body: data,
    onSuccess: (json) => TokenDto.fromJson(json)
  );
  


}